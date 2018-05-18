From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4.9 27/33] futex: Remove duplicated code and fix
 undefined behaviour
Date: Fri, 18 May 2018 11:01:41 +0200
Message-ID: <20180518090141.GA10227@kroah.com>
References: <20180518081535.096308218@linuxfoundation.org>
 <20180518081536.166573281@linuxfoundation.org>
 <e8dc5f94-3b52-dcf0-3b5e-b442bde7d803@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526634118;
        bh=1SRWfoD/psW265W0vT6SkEYVwFaJZV//o8sPscC1Ots=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yG3qvLwRGv7O+CGbyHALAoDhrv5hXvUquGE09lGU2oBdq7COnfz28qPQxLWrVQ8LY
         7g602wZdp5Z08Kb70DWy7zYY4LLYiFL+qCl6pJGo25Hgf2g0+xQRzXMmzkbqG28ksx
         4ZQvckvd4d6AA4/uXwbmgAeh2c99asU7GZdxE3J8=
Content-Disposition: inline
In-Reply-To: <e8dc5f94-3b52-dcf0-3b5e-b442bde7d803@suse.cz>
Sender: stable-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Russell King <rmk+kernel@armlinux.org.uk>, "Darren Hart (VMware)" <dvhart@infradead.org>, linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <matt>

On Fri, May 18, 2018 at 10:30:24AM +0200, Jiri Slaby wrote:
> On 05/18/2018, 10:16 AM, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me k=
now.
> >=20
> > ------------------
> >=20
> > From: Jiri Slaby <jslaby@suse.cz>
> >=20
> > commit 30d6e0a4190d37740e9447e4e4815f06992dd8c3 upstream.
> ...
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -1458,6 +1458,45 @@ out:
> >  	return ret;
> >  }
> > =20
> > +static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user =
*uaddr)
> > +{
> > +	unsigned int op =3D	  (encoded_op & 0x70000000) >> 28;
> > +	unsigned int cmp =3D	  (encoded_op & 0x0f000000) >> 24;
> > +	int oparg =3D sign_extend32((encoded_op & 0x00fff000) >> 12, 12);
> > +	int cmparg =3D sign_extend32(encoded_op & 0x00000fff, 12);
>=20
> 12 is wrong here =E2=80=93 wherever you apply this, you need also a follo=
w-up fix:
> commit d70ef22892ed6c066e51e118b225923c9b74af34
> Author: Jiri Slaby <jslaby@suse.cz>
> Date:   Thu Nov 30 15:35:44 2017 +0100
>=20
>     futex: futex_wake_op, fix sign_extend32 sign bits

Thanks for letting me know, I've now queued it up to the needed trees.

greg k-h
