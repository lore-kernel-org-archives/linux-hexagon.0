From: Lennox Wu <lennox.wu@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian
 explicitly
Date: Fri, 15 Aug 2014 02:27:12 +0800
Message-ID: <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
References: <53ECE9DD.80004@gmail.com>
 <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1691057985918365743=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
 h=mime-version:in-reply-to:references:date:message-id:subject:from:to
 :cc:content-type;
 bh=jmeBwov4/qrxMSf7MGznNkUf9pULXNsIJ7Mq5tkdDZ4=;
 b=I1PZGB6XBoapDerCDejyMkcOhoG2gLi4YUDKQgBM31GgkBfs7O1IGJtJy6o1/LwFEt
 LAHPlpfLxd7fjvG5NkxbRczPe7VHX0WMyv+rZQGLOuTQ+3S506qGw3Oj7ANTK+pZUsr5
 NA1aMvAtkozuBKoWKOJzZbCRuu5m0QAZIxHjhXf85G84aMk6kuzKgvbgv6OzcVJRgmgo
 ANtjseEzBRLYgiCUlZD3mB35zXYhgiQ6AZWDl44ShckDvxBqnOgi1kKIzG5blRNwtYMy
 yUWjT+IKtxOln5s5/wTJ8gLZCabYOO8mHIiAShlz5EtVxbb0yxrrXTA0ezsNfrwD1lHb
 25gA==
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "a-jacquiot@ti.com" <a-jacquiot@ti.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux@lists.openrisc.net" <linux@lists.openrisc.net>, "will.deacon@arm.com" <will.deacon@arm.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>, "paulus@samba.org" <paulus@samba.org>, "hpa@zytor.com" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "gxt@mprc.pku.edu.cn" <gxt@mprc.pku.edu.cn>, Jean Delvare <jdelvare@suse.de>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "jonas@southpole.se" <jonas@southpole.se>, Liqin Chen <liqin.linux@gmail.com>, "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>, linux-am33-list@red

--===============1691057985918365743==
Content-Type: multipart/alternative; boundary=485b397dd5e5ad1cec05009b0d88

--485b397dd5e5ad1cec05009b0d88
Content-Type: text/plain; charset=UTF-8

I don't think it's necessary, what's the benfit?




2014-08-15 2:21 GMT+08:00 Vineet Gupta <Vineet.Gupta1@synopsys.com>:

> On Thursday 14 August 2014 09:55 AM, Chen Gang wrote:
> > Normal architectures:
> >
> >  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
> >
> >  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
> >                   score, unicore32, x86
> >
> >  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh
> >
> > Special architectures:
> >
> >  - Deside by compiler: microblaze, tile, xtensa.
> >
> >  - Deside by building host: um
> >
> >  - Next, need improve Kbuild to probe endian to deside whether need mark
> >    __BUILDING_TIME_BIG_ENDIAN__ before real config.
> >
> > Another improvements:
> >
> >  - score: use '\t' instead of ' '.
> >
> >  - s390: sort the select value in alpha order.
> >
> > Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> > ---
> >  arch/alpha/Kconfig      |  1 +
> >  arch/arc/Kconfig        |  1 +
> >  arch/arm/Kconfig        |  1 +
> >  arch/arm64/Kconfig      |  1 +
> >  arch/avr32/Kconfig      |  1 +
> >  arch/blackfin/Kconfig   |  1 +
> >  arch/c6x/Kconfig        |  1 +
> >  arch/cris/Kconfig       |  1 +
> >  arch/frv/Kconfig        |  1 +
> >  arch/hexagon/Kconfig    |  1 +
> >  arch/ia64/Kconfig       |  1 +
> >  arch/m32r/Kconfig       |  1 +
> >  arch/m68k/Kconfig       |  1 +
> >  arch/metag/Kconfig      |  1 +
> >  arch/microblaze/Kconfig |  2 ++
> >  arch/mips/Kconfig       |  1 +
> >  arch/mn10300/Kconfig    |  1 +
> >  arch/openrisc/Kconfig   |  1 +
> >  arch/parisc/Kconfig     |  1 +
> >  arch/powerpc/Kconfig    |  1 +
> >  arch/s390/Kconfig       |  3 ++-
> >  arch/score/Kconfig      | 21 +++++++++++----------
> >  arch/sparc/Kconfig      |  1 +
> >  arch/tile/Kconfig       |  2 ++
> >  arch/um/Kconfig.common  |  2 ++
> >  arch/unicore32/Kconfig  |  1 +
> >  arch/x86/Kconfig        |  1 +
> >  arch/xtensa/Kconfig     |  2 ++
> >  init/Kconfig            |  6 ++++++
> >  29 files changed, 49 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> > index b7ff9a3..1cb7426 100644
> > --- a/arch/alpha/Kconfig
> > +++ b/arch/alpha/Kconfig
> > @@ -27,6 +27,7 @@ config ALPHA
> >       select MODULES_USE_ELF_RELA
> >       select ODD_RT_SIGACTION
> >       select OLD_SIGSUSPEND
> > +     select CPU_LITTLE_ENDIAN
> >       help
> >         The Alpha is a 64-bit general-purpose processor designed and
> >         marketed by the Digital Equipment Corporation of blessed memory,
> > diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> > index 9596b0a..e939abd 100644
> > --- a/arch/arc/Kconfig
> > +++ b/arch/arc/Kconfig
> > @@ -35,6 +35,7 @@ config ARC
> >       select OF_EARLY_FLATTREE
> >       select PERF_USE_VMALLOC
> >       select HAVE_DEBUG_STACKOVERFLOW
> > +     select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
>
> It is not clear what exactly are you trying to fix. What doesn't work w/o
> this
> patch !
>
> -Vineet
>

--485b397dd5e5ad1cec05009b0d88
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I don&#39;t think it&#39;s necessary, what&#39;s the =
benfit?</div><div><br></div><div><br></div></div><div class=3D"gmail_extra"=
><br><br><div class=3D"gmail_quote">2014-08-15 2:21 GMT+08:00 Vineet Gupta =
<span dir=3D"ltr">&lt;<a href=3D"mailto:Vineet.Gupta1@synopsys.com" target=
=3D"_blank">Vineet.Gupta1@synopsys.com</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
hursday 14 August 2014 09:55 AM, Chen Gang wrote:<br>
&gt; Normal architectures:<br>
&gt;<br>
&gt;=C2=A0 - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc<br=
>
&gt;<br>
&gt;=C2=A0 - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn=
10300,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sc=
ore, unicore32, x86<br>
&gt;<br>
&gt;=C2=A0 - Choose in config time: arc, arm, arm64, c6x, m32r, mips, power=
pc, sh<br>
&gt;<br>
&gt; Special architectures:<br>
&gt;<br>
&gt;=C2=A0 - Deside by compiler: microblaze, tile, xtensa.<br>
&gt;<br>
&gt;=C2=A0 - Deside by building host: um<br>
&gt;<br>
&gt;=C2=A0 - Next, need improve Kbuild to probe endian to deside whether ne=
ed mark<br>
&gt;=C2=A0 =C2=A0 __BUILDING_TIME_BIG_ENDIAN__ before real config.<br>
&gt;<br>
&gt; Another improvements:<br>
&gt;<br>
&gt;=C2=A0 - score: use &#39;\t&#39; instead of &#39; &#39;.<br>
&gt;<br>
&gt;=C2=A0 - s390: sort the select value in alpha order.<br>
&gt;<br>
&gt; Signed-off-by: Chen Gang &lt;<a href=3D"mailto:gang.chen.5i5j@gmail.co=
m">gang.chen.5i5j@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 arch/alpha/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/arc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/arm64/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/avr32/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/blackfin/Kconfig=C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 arch/c6x/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/cris/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 arch/frv/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/hexagon/Kconfig=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/ia64/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 arch/m32r/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 arch/m68k/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 arch/metag/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/microblaze/Kconfig |=C2=A0 2 ++<br>
&gt;=C2=A0 arch/mips/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 arch/mn10300/Kconfig=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/openrisc/Kconfig=C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 arch/parisc/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 arch/powerpc/Kconfig=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/s390/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
&gt;=C2=A0 arch/score/Kconfig=C2=A0 =C2=A0 =C2=A0 | 21 +++++++++++---------=
-<br>
&gt;=C2=A0 arch/sparc/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/tile/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 arch/um/Kconfig.common=C2=A0 |=C2=A0 2 ++<br>
&gt;=C2=A0 arch/unicore32/Kconfig=C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/x86/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 arch/xtensa/Kconfig=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 init/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 =
++++++<br>
&gt;=C2=A0 29 files changed, 49 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig<br>
&gt; index b7ff9a3..1cb7426 100644<br>
&gt; --- a/arch/alpha/Kconfig<br>
&gt; +++ b/arch/alpha/Kconfig<br>
&gt; @@ -27,6 +27,7 @@ config ALPHA<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select MODULES_USE_ELF_RELA<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select ODD_RT_SIGACTION<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select OLD_SIGSUSPEND<br>
&gt; +=C2=A0 =C2=A0 =C2=A0select CPU_LITTLE_ENDIAN<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The Alpha is a 64-bit general-purpose=
 processor designed and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0marketed by the Digital Equipment Cor=
poration of blessed memory,<br>
&gt; diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig<br>
&gt; index 9596b0a..e939abd 100644<br>
&gt; --- a/arch/arc/Kconfig<br>
&gt; +++ b/arch/arc/Kconfig<br>
&gt; @@ -35,6 +35,7 @@ config ARC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select OF_EARLY_FLATTREE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PERF_USE_VMALLOC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select HAVE_DEBUG_STACKOVERFLOW<br>
&gt; +=C2=A0 =C2=A0 =C2=A0select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN<br>
<br>
</div></div>It is not clear what exactly are you trying to fix. What doesn&=
#39;t work w/o this<br>
patch !<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Vineet<br>
</font></span></blockquote></div><br></div>

--485b397dd5e5ad1cec05009b0d88--

--===============1691057985918365743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============1691057985918365743==--
