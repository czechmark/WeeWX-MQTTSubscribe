# only upload once
if [ "$COVERALLS_UPLOAD" = "true" ]; then
  coveralls
fi

# patch up dirs for sonar
sed -i 's/classname="/classname="bin\/user\/tests\/unit./g' nosetests.xml
sed -i 's/classname="/classname="bin\/user\/tests\/func./g' nosetests2.xml

# only upload once
if [ "$SONAR_UPLOAD" = "true" ]; then
  sonar-scanner \
    -Dsonar.organization=bellrichm \
    -Dsonar.projectKey=bellrichm_WeeWX-MQTTSubscribe \
    -Dsonar.branch.name=master \
    -Dsonar.branch.target=master \
    -Dsonar.sources=./bin/user/MQTTSubscribe.py \
    -Dsonar.tests=./bin/user/tests \
    -Dsonar.language=py \
    -Dsonar.python.xunit.reportPath=nosetests*.xml \
    -Dsonar.python.xunit.skipDetails=false \
    -Dsonar.python.coverage.reportPaths=coverage.xml \
    -Dsonar.python.coveragePlugin=cobertura \
    -Dsonar.python.pylint.reportPath=pylint.txt \
    -Dsonar.host.url=https://sonarcloud.io \
    -Dsonar.login=$SKEY \
    #-X
fi
