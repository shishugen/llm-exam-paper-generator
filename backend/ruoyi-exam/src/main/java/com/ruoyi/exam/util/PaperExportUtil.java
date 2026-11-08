package com.ruoyi.exam.util;

import java.io.IOException;
import java.io.OutputStream;
import org.springframework.stereotype.Component;
import java.util.List;
import java.util.Map;

import org.apache.poi.xwpf.usermodel.BreakType;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFRun;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;

// 导出 Word：前面是试题卷，分页后是答案卷
@Component
public class PaperExportUtil
{
    public static void export(String title, List<Map<String, Object>> rows, OutputStream out) throws IOException
    {
        try (XWPFDocument doc = new XWPFDocument())
        {
            paragraph(doc, title, true, 16);
            paragraph(doc, "姓名：____________    学号：____________    得分：__________", false, 11);
            paragraph(doc, "", false, 11);

            int no = 1;
            for (Map<String, Object> r : rows)
            {
                paragraph(doc, no + ". " + str(r.get("stem")) + "（" + str(r.get("score")) + " 分）", false, 11);
                String options = formatOptions(r.get("options"));
                if (!options.isEmpty())
                {
                    paragraph(doc, "    " + options, false, 10);
                }
                paragraph(doc, "", false, 10);
                no++;
            }

            // 分页符：试题卷与答案卷分开
            doc.createParagraph().createRun().addBreak(BreakType.PAGE);
            paragraph(doc, "参考答案与解析", true, 16);
            int i = 1;
            for (Map<String, Object> r : rows)
            {
                paragraph(doc, i + ". 答案：" + str(r.get("answer")), false, 11);
                paragraph(doc, "   解析：" + str(r.get("analysis")), false, 10);
                i++;
            }
            doc.write(out);
        }
    }

    private static void paragraph(XWPFDocument doc, String text, boolean bold, int size)
    {
        XWPFRun run = doc.createParagraph().createRun();
        run.setText(text == null ? "" : text);
        run.setBold(bold);
        run.setFontSize(size);
    }

    // 选项在库里是 JSON 字符串，排成 A. xxx  B. xxx
    private static String formatOptions(Object value)
    {
        if (value == null)
        {
            return "";
        }
        String s = String.valueOf(value);
        try
        {
            JSONArray arr = JSON.parseArray(s);
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < arr.size(); i++)
            {
                JSONObject o = arr.getJSONObject(i);
                sb.append(o.getString("key")).append(". ").append(o.getString("value")).append("   ");
            }
            return sb.toString();
        }
        catch (Exception e)
        {
            return s;
        }
    }

    private static String str(Object o)
    {
        return o == null ? "" : String.valueOf(o);
    }
}
