#!/bin/bash
# 基于大语言模型的试卷生成系统 - 本机一键启动
# 用法: ./启动系统.sh         启动
#       ./启动系统.sh stop    停止
#       ./启动系统.sh restart 重启

BASE="/Users/shishugen/Documents/大学/毕业论文/exam-gen-system"
NODE="/Users/shishugen/.workbuddy/binaries/node/versions/22.22.2/bin/npm"

stop_all() {
  lsof -ti tcp:8080 2>/dev/null | xargs kill 2>/dev/null
  lsof -ti tcp:5173 2>/dev/null | xargs kill 2>/dev/null
}

start_all() {
  if ! redis-cli ping >/dev/null 2>&1; then
    echo "[1/4] 启动 Redis ..."
    redis-server --daemonize yes
  else
    echo "[1/4] Redis 已在运行"
  fi

  if ! mysqladmin ping >/dev/null 2>&1; then
    echo "MySQL 没启动，请先执行: brew services start mysql"
    exit 1
  fi
  echo "[2/4] MySQL 正常"

  stop_all
  echo "[3/4] 启动后端 8080 ..."
  cd "${BASE}/backend" || exit 1
  nohup env -u SERVER__PORT -u SERVER__HOST java -jar ruoyi-admin/target/ruoyi-admin.jar --server.port=8080 > /tmp/ruoyi-backend.log 2>&1 &

  echo "[4/4] 启动前端 5173 ..."
  cd "${BASE}/frontend" || exit 1
  nohup "${NODE}" run dev > /tmp/ruoyi-frontend.log 2>&1 &

  echo ""
  echo "等 10 秒左右，浏览器打开: http://localhost:5173"
  echo "账号 admin / 密码 admin123"
  echo "后端日志: tail -f /tmp/ruoyi-backend.log"
  echo "前端日志: tail -f /tmp/ruoyi-frontend.log"
}

case "$1" in
  stop)
    stop_all
    echo "已停止后端与前端"
    ;;
  restart)
    stop_all
    sleep 2
    start_all
    ;;
  *)
    start_all
    ;;
esac
