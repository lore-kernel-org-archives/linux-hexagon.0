From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Date: Mon, 17 Jul 2023 17:51:31 +0100
Message-ID: <285d346e-14e7-4f43-9b5b-faded6205142@sirena.org.uk>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
 <b389274a-abed-40dc-8e33-7ce922ea9b61@sirena.org.uk>
 <87acbb49fa83b0e3f261315a531e105da9e5b9d6.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="klyEM8Lfv/18WVhb"
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689612706;
        bh=GDoZ+CsfFo9PibsTP4iZm+ttTgfHxn11DDJbAlCFH8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEoHMX2JdQeUVyNkgdWBKI6yr5pe/INc5DfODCru+00fN8J5XJg/01FraxC5Uf+FG
         XLGyykcZarElT+yfQ88/qw3rxbdtmQwlMm4MVMWcjVA8W1BzI++pek5YZKKBwI7XR6
         Vc/WH98m5BnS7DdeM2++eaKr94hk2O0k89Bc1b9ybe/FsHvQBWZ/9PaJFm5XUvbhPh
         78TOOOqQ+Nd6w2oOqOYhgVZm+Y7ykGxydEmczeSZwjlePi5nZMkHrFdDg9hL8zxSio
         SCc95tvYUaXDed+x2C7VwVXHcnKo0+0JBdhxm/Vl4xw/gxBOwJrvOMJAyCgSMZ+3MK
         +O+f2UpDtYbxQ==
Content-Disposition: inline
In-Reply-To: <87acbb49fa83b0e3f261315a531e105da9e5b9d6.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Schimpe, Christina" <christina.schimpe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Yang, Weijiang" <weijiang.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org" <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, "rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "Torvalds, Linus" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arnd@


--klyEM8Lfv/18WVhb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 17, 2023 at 03:55:50PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2023-07-14 at 23:57 +0100, Mark Brown wrote:

> > The same issue seems to apply with the version that was in -next
> > based
> > on v6.4-rc4 too.

> The version in your branch is not the same as the version in tip (which
> had a squashed build fix). I was able to reproduce the build error with
> your branch. But not with the one in tip rebased on v6.5-rc1. So can
> you try this version:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/shstk&id=899223d69ce9f338056f4c41ef870d70040fc860

Ah, I'd not seen that patch or that tip had been rebased - I'd actually
been using literally the branch from tip as my base at whatever point I
last noticed it changing up until I rebased onto -rc1.

--klyEM8Lfv/18WVhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS1cZIACgkQJNaLcl1U
h9DfWwf/Qv2sx8Qywn2HA+F1wJsVWOOqaPIZzIVBQ5Kg2bysQK3YMNLLZWKdXMsh
sTgXGVlr5oANLjP/hYxvcaxk16N1y51q6PuBh4lJN1w37tEdph1ZIcSejQY/jKpf
fKFWHZ++2w+lXvIOB/7rYQe+XutmQzCVmL0Cod8zxf2UhC4WJe9/3RCKxi6rfxuV
NXldTW7h7dqnurbev4TX4npwjcetNGofPUer7VZD7o1vRKXvX9VLG42UbeV4cu+g
ICKZmGwC9G23gWg0Ql2QkeOr43PLBo4AocKhyO6B22uYLOrA8BQHJUrbnD4ZUyD+
4rWq0iWXOnrixnw11LOSSIVZ2HkwmQ==
=SaIl
-----END PGP SIGNATURE-----

--klyEM8Lfv/18WVhb--
