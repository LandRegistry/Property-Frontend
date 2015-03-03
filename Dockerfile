FROM rails:onbuild
Maintainer "Mikael Allison"
ENV PROPERTY_API 'http://landregistry.local:8001'
ENV RAILS_ENV production
ENV SECRET_KEY_BASE `bundle exec rake secret`
ENV RAILS_SERVE_STATIC_FILES true
EXPOSE 8080
ENTRYPOINT unicorn
