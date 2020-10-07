#!/bin/bash

AWS_S3_BUCKET=www.contentcamel.io

path_join() {
                part1=$1
                part2=$2
                if [ "${part1: -1}" == "/" ]; then
                    part1=${part1}${part2}
                else
                    part1=${part1}/${part2}
                fi
                echo $part1
              }

              for redirect in $(cat ./dist/redirects.json | jq -c '.[]'); do
                from=$(echo $redirect | jq '. | .Condition.KeyPrefixEquals' | cut -d "\"" -f 2)
                to=$(echo $redirect | jq '. | .Redirect.ReplaceKeyPrefixWith' | cut -d "\"" -f 2)

                from=$(path_join $from "index.html")

                aws s3 cp s3://${AWS_S3_BUCKET}${from} s3://${AWS_S3_BUCKET}${from} --website-redirect ${to} --metadata-directive REPLACE
		# echo ${AWS_S3_BUCKET}${from}
done
