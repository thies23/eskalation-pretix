FROM pretix/standalone:stable
USER root
RUN apt update
RUN apt install ghostscript -y
RUN apt clean
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade wheel
RUN pip3 install --upgrade setuptools
RUN pip3 install pretix-passbook
RUN pip3 install pretix-newsletter-ml
RUN pip3 install pretix-servicefees
RUN pip3 install pretix-sofort
RUN pip3 install pretix-sepadebit
RUN pip3 install pretix-pages
RUN pip3 install pretix-fontpack-free
RUN pip3 install pretix-cashpayment
RUN pip3 install pretix-zugferd
RUN pip3 install pretix-sumup-payment
RUN pip3 install ghostscript
RUN pip3 install pretix-oidc
ENV DJANGO_SETTINGS_MODULE=production_settings

USER pretixuser
RUN cd /pretix/src && make production
USER root
RUN chmod -R o+rX /pretix/src/pretix/static.dist/
RUN sed -i 's/user www-data www-data;/user pretixuser pretixuser;/' /etc/nginx/nginx.conf
USER pretixuser
