<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="title">
        <h1><xsl:apply-templates/></h1>
    </xsl:template>
    <xsl:template match="book">
      <h2><xsl:value-of select="title"/></h2>
      <p>Autor: <xsl:value-of select="author"/></p>
      <p>Erscheinungsjahr: <xsl:value-of select="year"/></p>
  </xsl:template>
</xsl:stylesheet>