<%def name="render(templateUrl)">
  <%
    import urllib2
    from django.conf import settings
    edx_env = settings.APPSEMBLER_FEATURES['ENVIRONMENT']

    if settings.APPSEMBLER_FEATURES['GYMCMS_URL'] is None:
      gymcms_url = False
    else:
      gymcms_url = settings.APPSEMBLER_FEATURES['GYMCMS_URL']

    ## this does nothing right now
    ## if request.GET.get('buildid'):
    ##   gymcms_url = 'https://deploy-preview-' + request.GET.get('buildid') + '--thegymcms.netlify.app/'

    ## turn the partial url passed in into a fully GET-able url based on which environment we're in
    if templateUrl:
      ## Test to ensure dev actually delivers the partial like it should
      fullUrl = 'https://dev.thegymcms.com/' + templateUrl

      ## use GYMCMS_URL defined in settings
      ## if gymcms_url:
      ##   fullUrl = gymcms_url + templateUrl
      ##   ## temporarily look at an in-progress build
      ##   ## fullUrl = 'https://deploy-preview-650--thegymcms.netlify.app/' + templateUrl
      ## else:
      ##   if edx_env == 'staging':
      ##     fullUrl = 'https://staging.thegymcms.com/' + templateUrl
      ##   else:
      ##     fullUrl = 'https://thegymcms.com/' + templateUrl

      ## provided the last step worked, use a try block to pull that data from the web render a hidden div if it fails, so it doesn't crash the rest of the page.
      if fullUrl:
        try:
          renderedContent = urllib2.urlopen(fullUrl).read()
        except:
          renderedContent = '<!-- Error loading: ' + fullUrl + ' -->'
  %>

  %if renderedContent:
    ${renderedContent}
  %endif
</%def>
