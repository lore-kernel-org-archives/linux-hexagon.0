From: Vishal Moola <vishal.moola@gmail.com>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Thu, 1 Jun 2023 01:22:03 -0700
Message-ID: <CAOzc2pxnb6WXoVK5JXX42R0Q6FK59Q1uebQskK2fxLn6DuicqA@mail.gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
 <20230531213032.25338-31-vishal.moola@gmail.com> <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
 <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685607734; x=1688199734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3q8fSv1CYQ8OeBSkoHHq8yQzPVMEdcVj1sJJBohCe0=;
        b=scnpKoycafdSA6Zmoxe64NtU1IPtpP1XoN7u6BxbHgaNpHHpBaRgfB2X/NbVQI3XUI
         S43vtnrb0VpUQFKtCtNAL2Z4eQGxKB9jkDmQzBef6OSmzPFkANcNw2nEHbBaxtIGRJFx
         F2gdbWX0/JO50BjGXzMMRjG/dVaN6/37Aaxe3j2XyiD9NBGl22snChdmfv7CpIBT4YsT
         wzEsBAOaAGJLasaxdabRza57BmBoAT7cVmGOq5aUEFhtYj/c1WejBdPyTkL2OU+y9vxz
         zNiBma0es8vOX0CahjWds9KH8J6DH6xHzp6sGGczNoDJQcyp7Q2snP8wt+QQc7Qs4GOa
         fyBw==
In-Reply-To: <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

On Thu, Jun 1, 2023 at 12:28=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Geert!
>
> On Thu, 2023-06-01 at 09:20 +0200, Geert Uytterhoeven wrote:
> > On Wed, May 31, 2023 at 11:33=E2=80=AFPM Vishal Moola (Oracle)
> > <vishal.moola@gmail.com> wrote:
> > > Part of the conversions to replace pgtable constructor/destructors wi=
th
> > > ptdesc equivalents. Also cleans up some spacing issues.
> > >
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> >
> > LGTM, so
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I assume this series is supposed to go through some mm tree?

Hi Adrian,
I was going to have Andrew take this through mm-unstable
once it gets enough review.
