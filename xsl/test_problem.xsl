<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:strip-space elements="*"/>

    <xsl:template match="/article">
        <html>
            <head>
                <title>
                    <xsl:value-of select="title"/>
                </title>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="title"/>
                </h1>
                <hr/>
                <h3>
                    Table of content
                </h3>
                <ol>
                    <xsl:apply-templates select="section" mode="toc"/>
                </ol>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/article/section">
        <h2>
            <a name="{generate-id()}">
                <xsl:value-of select="title"/>
            </a>
        </h2>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="section" mode="toc">
        <li>
            <a href="#{generate-id()}">
                <xsl:value-of select="title"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="title">
</xsl:template>

    <xsl:template match="section">
        <xsl:variable name="depth" select="count(ancestor::section)+1"/>
        <div class="section">
            <xsl:call-template name="handle-title">
                <xsl:with-param name="depth" select = "$depth" />
                <xsl:with-param name="title" select = "title" />
            </xsl:call-template>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="section/title">
    </xsl:template>

    <xsl:template match="para">
        <p class="para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template name = "handle-title">
        <xsl:param name = "depth" />
        <xsl:param name = "title" />

        <xsl:element name="h{$depth}">
            <xsl:value-of select="$title"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="code">
        <code class="code">
            <xsl:apply-templates/>
        </code>
    </xsl:template>

    <xsl:template match="orderedlist">
        <ol class="orderedlist">
            <xsl:apply-templates/>
        </ol>
    </xsl:template>

    <xsl:template match="orderedlist/listitem">
        <li class="listitem">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="itemizedlist">
        <ul class="itemizedlist">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="itemizedlist/listitem">
        <li class="listitem">
            <xsl:apply-templates/>
        </li>
    </xsl:template>

    <xsl:template match="emphasis">
        <em class="emphasis">
            <xsl:apply-templates/>
        </em>
    </xsl:template>

    <xsl:template match="link">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="@linkend"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="keycap">
        <b class="keycap">
            <xsl:apply-templates/>
        </b>
    </xsl:template>

    <xsl:template match="ulink">
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="@url"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>



</xsl:stylesheet>