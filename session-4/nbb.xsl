<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                version="1.0">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title>
                <meta charset="UTF-8"/>
                <style type="text/css">
                    body {
                        font-family: Arial, sans-serif;
                        line-height: 1.5;
                        margin: 2em;
                    }
                    .opener {
                        color: darkgreen;
                        font-style: italic;
                        margin-bottom: 1em;
                    }
                    .closer {
                        color: darkblue;
                        font-weight: bold;
                        margin-top: 2em;
                    }
                    strong {
                        color: darkred;
                    }
                    em {
                        color: darkorange;
                    }
                    u {
                        text-decoration: underline dotted;
                        color: #9168ba;
                    }
                    hr {
                        border: none;
                        border-top: 1px solid #ccc;
                        margin: 2em 0;
                    }
                </style>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </h1>
                
                <h2>Metadaten</h2>
                <p><strong>Bearbeiter: </strong>
                    <xsl:for-each select="//tei:respStmt/tei:name">
                        <xsl:value-of select="."/>
                        <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                    </p>

                <p><strong>Datum: </strong> <xsl:value-of select="//tei:correspAction[@type='sent']/tei:date"/></p>
                <p><strong>Sender: </strong> <xsl:value-of select="//tei:correspAction[@type='sent']/tei:orgName"/></p>
                <p><strong>Empfänger: </strong>
                    <xsl:choose>
                        <xsl:when test="//tei:correspAction[@type='received']/tei:orgName">
                        <xsl:value-of select="//tei:correspAction[@type='received']/tei:orgName"/>
                        </xsl:when>
                        <xsl:when test="//tei:correspAction[@type='received']/tei:persName">
                        <xsl:value-of select="//tei:correspAction[@type='received']/tei:persName"/>
                        </xsl:when>
                        <xsl:when test="//tei:correspAction[@type='received']/tei:placeName">
                        <xsl:value-of select="//tei:correspAction[@type='received']/tei:placeName"/>
                        </xsl:when>
                        <xsl:otherwise>
                        <xsl:text>unbekannt</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    </p>

                <h2>Faksimile</h2>
                <xsl:for-each select="//tei:graphic">
                    <img width="500px">
                        <xsl:attribute name="src">
                            <xsl:value-of select="@url"/>
                        </xsl:attribute>
                    </img>
                </xsl:for-each>

                <h2>diplomatischer Text</h2>
                <xsl:apply-templates select="//tei:div[@type='diplomatic']"/>

                <h2>normalisierter Text</h2>
                <xsl:apply-templates select="//tei:div[@type='normalized']"/>
            </body>
        </html>
    </xsl:template>

    <!-- Template zum Verarbeiten von Absätzen -->
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Template für placeName, persName, orgName -->
    <xsl:template match="tei:persName">
        <strong><xsl:apply-templates/></strong>
    </xsl:template>

    <xsl:template match="tei:placeName">
        <em><xsl:apply-templates/></em>
    </xsl:template>

    <xsl:template match="tei:orgName">
        <u><xsl:apply-templates/></u>
    </xsl:template>

    <!-- Templates für opener, closer, pb -->
    <xsl:template match="tei:opener">
        <div class="opener"><xsl:apply-templates/></div>
    </xsl:template>

    <xsl:template match="tei:closer">
        <div class="closer"><xsl:apply-templates/></div>
    </xsl:template>

    <xsl:template match="tei:pb">
        <hr/>
    </xsl:template>

</xsl:stylesheet>