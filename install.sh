#!/bin/bash

# 압축 해제할 파일명 설정
ARCHIVE="MonitoringDashboard.tar.gz"


# 압축을 해제할 디렉토리를 지정합니다.
# 이 예에서는 현재 디렉토리에 압축을 해제합니다.
DIRECTORY="MonitoringDashboard"

#make directory
if [ ! -d "$DIRECTORY" ]; then
    echo "디렉토리 생성: $DIRECTORY"
    mkdir -p $DIRECTORY
    echo ""
fi

# 압축 해제
echo "압축 파일을 해제합니다."
tar -xzvf $ARCHIVE -C $DIRECTORY
echo ""

# 사용자에게 실행 권한 부여에 대한 동의 요청
read -p "스크립트 파일에 실행 권한을 부여하시겠습니까? (y/n) " consent

if [[ $consent == "y" || $consent == "Y" ]]; then
    # 실행 권한 부여 대상 파일 또는 디렉토리 지정
    # 예: Monitoring/ 디렉토리 내의 모든 파일에 실행 권한 부여
    echo "실행 권한을 부여합니다..."
    chmod -R +x MonitoringDashboard/*
    echo "실행 권한이 부여되었습니다."
else
    echo "실행 권한 부여가 거부되었습니다."
fi

