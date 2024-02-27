#!/bin/bash

# 압축 해제할 파일명 설정
ARCHIVE="MonitoringDashboard.tar.gz"

# 스크립트 파일을 저장할 하위 디렉토리 이름
SCRIPT_DIR="scripts"

# 압축 파일 존재 여부 확인
if [ ! -f "$ARCHIVE" ]; then
    echo "압축 파일 $ARCHIVE를 찾을 수 없습니다."
    exit 1
fi

# 압축 해제
echo "현재 디렉토리에 압축 파일을 해제합니다."
tar -xzvf $ARCHIVE
echo ""

# scripts 디렉토리 생성 및 Dashboard.sh를 제외한 스크립트 이동
mkdir -p $SCRIPT_DIR
echo "Dashboard.sh를 제외한 스크립트를 $SCRIPT_DIR 디렉토리로 이동합니다."
find . -maxdepth 1 -type f -name "*.sh" ! -name "Dashboard.sh" -exec mv {} $SCRIPT_DIR/ \;
echo ""

# 사용자에게 실행 권한 부여에 대한 동의 요청
read -p "스크립트 파일에 실행 권한을 부여하시겠습니까? (y/n) " consent

if [[ $consent == "y" || $consent == "Y" ]]; then
    # Dashboard.sh와 scripts 디렉토리 내의 모든 파일에 실행 권한 부여
    echo "실행 권한을 부여합니다..."
    chmod +x Dashboard.sh
    chmod -R +x $SCRIPT_DIR/
    echo "실행 권한이 부여되었습니다."
    echo ""

    # Dashboard.sh 실행 여부 확인
    read -p "Dashboard.sh를 실행하시겠습니까? (y/n) " runDashboard

    if [[ $runDashboard == "y" || $runDashboard == "Y" ]]; then
        # Dashboard.sh 실행
        echo "Dashboard.sh를 실행합니다..."
        ./Dashboard.sh
    else
        echo "Dashboard.sh 실행이 취소되었습니다."
    fi
else
    echo "실행 권한 부여가 거부되었습니다."
fi

