From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH v3 4/8] x86: stop exporting msr-index.h to userland
Date: Fri, 13 Jan 2017 17:08:34 +0100
Message-ID: <dd826bc7-e1ef-be29-e0c3-692afb346036@6wind.com>
References: <1484304406-10820-5-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <25483.1484322229@warthog.procyon.org.uk>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-media-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:references:to:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Avg3is2joRsoOW1SoBexrSu2HFewlOZOKE9YrkazkLI=;
        b=fL4eZGCF2ZGuK8MA5HcRUAW+LfACU/iv9o7m2cMmr5OAMRnlyRsPSNNVf+6mJJ+vtF
         +gAEqK7eTn3Flx/yyFHnn5JJWtcqtva21uJ+Nc5AyKcdZ9ZDVL+BtUPxfUnzf0hrQrkk
         torjHWgSMBVyVGn0rxA7ePORLTwaGT+wFAvv4V9NFxcwbZbdnG3Rc3sBH6bURFmsykWC
         JSiP51qEScCDWiowcRL8imt6EiAewCrf/aM4AV48isAyGlne52kULARPugTpfuR+RXoz
         L16OETZ9u/FZH2v0+ZpW0l/3D/e+S8uNeNKfzzZeunMY61OP2ZhRxArszkkGLg305J/u
         ksBw==
In-Reply-To: <25483.1484322229@warthog.procyon.org.uk>
Sender: linux-media-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Howells <dhowells@redhat.com>
Cc: arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, dr

Le 13/01/2017 =E0 16:43, David Howells a =E9crit :
>> -header-y +=3D msr-index.h
>=20
> I see it on my desktop as /usr/include/asm/msr-index.h and it's been ther=
e at
> least four years - and as such it's part of the UAPI.  I don't think you =
can
> remove it unless you can guarantee there are no userspace users.
I keep it in the v2 of the series, but the maintainer, Borislav Petkov, ask=
s me
to un-export it.

I will follow the maintainer decision.


Regards,
Nicolas
