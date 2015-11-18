#! /bin/sh
#comments

cd `dirname $0`

PID=$(ps | grep 'Update' | awk '$0!~/grep/{print $1}')
if(test -n "$PID")
then
    kill -9 ${PID}
fi

PID=$(ps | grep 'update' | awk '$0!~/grep/{print $1}')
if(test -n "$PID")
then
    kill -9 ${PID}
fi

PID=$(ps | grep 'PatientMonitor' | awk '$0!~/grep/{print $1}')
if(test -n "$PID")
then
    kill -9 ${PID}
fi

while(test -z $(ps | grep 'PatientMonitor' | awk '$0!~/grep/{print $1}'))
do
    ./PatientMonitor -qws
    case $? in
        160)
            if [ -x Update ]
            then
                ./Update -qws
            elif [ -x update ]
            then
                ./update -qws
            fi
            ;;
        161)
            if [ -x Update ]
            then
                ./Update -qws
            elif [ -x update ]
            then
                ./update -qws
            fi
            ;;
        *)
            sleep 1s
            ;;
    esac
done
