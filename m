From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH] Hexagon: Export raw I/O routines for modules
Date: Wed, 28 Jul 2021 10:08:31 -0500
Message-ID: <03be01d783c2$6e684420$4b38cc60$@codeaurora.org>
References: <20210708233849.3140194-1-nathan@kernel.org> <YQCiZSj1gfnF5x/d@Ryzen-9-3900X.localdomain>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627484925; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=3wwq0AErdGICOZ9un5uPRzTUaZOh9Woef+N1yP+Q6P8=; b=b/5f4x2MhMlsO17H3cmBueKURKOEaWiF9gQ2ZjCXUQqKCPFoQLUGDhhGyLkXy+X/aXvKkCi1
 TTgmW9YxzyNKMBeg/6UH6/N1wo29KbGA8d5wlrKAh/5Hy5f2a3B5wBjPs5MSDpqaUKtr4585
 xjknPWmUa4GmdFPj0XTq4Huze4k=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <YQCiZSj1gfnF5x/d@Ryzen-9-3900X.localdomain>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Nathan Chancellor' <nathan@kernel.org>, 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'Nick Desaulniers' <ndesaulniers@google.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, "'Manning, Sid'" <sidneym@quicinc.com>



> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
...
> On Thu, Jul 08, 2021 at 04:38:50PM -0700, Nathan Chancellor wrote:
...
> > Export these symbols so that modules can use them without any errors.
> >
> > Fixes: 013bf24c3829 ("Hexagon: Provide basic implementation and/or stubs
> for I/O routines.")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >
> > It would be nice if this could get into 5.14 at some point so that we
> > can build ARCH=hexagon allmodconfig in our CI.
> >
> >  arch/hexagon/lib/io.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/hexagon/lib/io.c b/arch/hexagon/lib/io.c
> > index d35d69d6588c..55f75392857b 100644
> > --- a/arch/hexagon/lib/io.c
> > +++ b/arch/hexagon/lib/io.c
> > @@ -27,6 +27,7 @@ void __raw_readsw(const void __iomem *addr, void
> *data, int len)
> >  		*dst++ = *src;
> >
> >  }
> > +EXPORT_SYMBOL(__raw_readsw);
> >
> >  /*
> >   * __raw_writesw - read words a short at a time
> > @@ -47,6 +48,7 @@ void __raw_writesw(void __iomem *addr, const void
> *data, int len)
> >
> >
> >  }
> > +EXPORT_SYMBOL(__raw_writesw);
> >
> >  /*  Pretty sure len is pre-adjusted for the length of the access
already */
> >  void __raw_readsl(const void __iomem *addr, void *data, int len)
> > @@ -62,6 +64,7 @@ void __raw_readsl(const void __iomem *addr, void
> *data, int len)
> >
> >
> >  }
> > +EXPORT_SYMBOL(__raw_readsl);
> >
> >  void __raw_writesl(void __iomem *addr, const void *data, int len)
> >  {
> > @@ -76,3 +79,4 @@ void __raw_writesl(void __iomem *addr, const void
> *data, int len)
> >
> >
> >  }
> > +EXPORT_SYMBOL(__raw_writesl);
> >
> > base-commit: f55966571d5eb2876a11e48e798b4592fa1ffbb7
> > --
> > 2.32.0.93.g670b81a890
> 
> Ping? Brian, if you do not want to carry this, can you give an ack so
> that Andrew can?

Acked-by: Brian Cain <bcain@codeaurora.org>

