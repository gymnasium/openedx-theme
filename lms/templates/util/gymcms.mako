<%def name="render(templateUrl)">
  <%
    import urllib2
    from django.conf import settings
    edx_env = settings.APPSEMBLER_FEATURES['ENVIRONMENT']

    if settings.APPSEMBLER_FEATURES['GYMCMS_URL'] is None:
      gymcms_url = 'Error: GYMCMS_URL not defined'
    else:
      gymcms_url = settings.APPSEMBLER_FEATURES['GYMCMS_URL']

    # this does nothing right now
    if request.GET.get('buildid'):
      gymcms_url = 'https://deploy-preview-' + request.GET.get('buildid') + '--thegymcms.netlify.app/'

    # turn the partial url passed in into a fully GET-able url
    # based on which environment we're in
    if templateUrl:
      ## Temporarily using `static` until we're ready to deploy to staging
      fullUrl = 'https://thegymcms.com/' + templateUrl

      if edx_env == 'staging':
        fullUrl = 'https://staging.thegymcms.com/' + templateUrl
        ## temporarily look at an in-progress build
        ## fullUrl = 'https://deploy-preview-650--thegymcms.netlify.app/' + templateUrl

      if edx_env == 'development':
        fullUrl = 'https://staging.thegymcms.com/' + templateUrl
        ## fullUrl = 'https://deploy-preview-650--thegymcms.netlify.app/' + templateUrl

      # provided the last step worked, use a try block to pull that data from the web
      # render a hidden div if it fails, so it doesn't crash the rest of the page.
      if fullUrl:
        try:
          renderedContent = urllib2.urlopen(fullUrl).read()
        except:
          renderedContent = '<!-- Error loading: ' + fullUrl + ' -->'
  %>

  %if renderedContent:
    <!-- ${gymcms_url} -->
    ${renderedContent}
  %endif
</%def>
