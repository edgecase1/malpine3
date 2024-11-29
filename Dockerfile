from alpine

ADD ./hacksudo /bin/hacksudo

FROM scratch
COPY --from=0 / /
RUN chown root:root /bin/hacksudo && chmod 4755 /bin/hacksudo && stat /bin/hacksudo

CMD [ "/bin/hacksudo" ] 
