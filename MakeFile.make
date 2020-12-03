pubsub-nodejs-verify:
	$(eval DATA := $(shell mktemp -u -t XXXXXXXX))
	kubeless topic publish --topic s3-nodejs --data '{"test": "$(DATA)"}'
	number="1"; \
	timeout="60"; \
	found=false; \
	while [ $$number -le $$timeout ] ; do \
		pod=`kubectl get po -oname -l function=pubsub-nodejs`; \
		logs=`kubectl logs $$pod | grep $(DATA)`; \
    	if [ "$$logs" != "" ]; then \
			found=true; \
			break; \
		fi; \
		sleep 1; \
		number=`expr $$number + 1`; \
	done; \
	$$found