#!/usr/bin/env bash
# 自动git推送机器人

# 默认的环境变量
# 默认按照年 月的方式存放
GIT_ROOT=/renj.io/apps/jjbot/jjapps_status

year=$(date +%Y)
month=$(date +%m)
file_date=$(date +%Y-%m-%d)

first_dir=$year
second_dir=$month

data=''
get_apps_status()
{
  :>status_${file_date}.txt
  apps=$(/renj.io/zeus/zeus.sh show)
  for app in $apps
  do
    # 暂时需要对nginx处理
    current_app=$(echo $app | grep -v \(*\) | grep -v \n)
    if [ -z $current_app ];then
      continue
    fi
    data="$current_app: $(/renj.io/zeus/zeus.sh status $current_app)"
    echo "${data}" >> status_${file_date}.txt
  done
}

# 优先清空
cd ${GIT_ROOT}
if [ -d ${first_dir} ]
then
  cd ${first_dir}
  if [ -d ${second_dir} ]
  then
    cd ${second_dir}
    get_apps_status
  else
    mkdir ${second_dir}
    cd ${second_dir}
    get_apps_status
  fi
else
  mkdir ${first_dir}
  cd ${first_dir}
  if [ -d ${second_dir} ]
  then
    cd ${second_dir}
    get_apps_status
  else
    mkdir ${second_dir}
    cd ${second_dir}
    get_apps_status
  fi
fi

# start git
cd ${GIT_ROOT}
git add .
git commit -m "add status on ${file_date}"
git push origin
