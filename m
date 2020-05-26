From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH] compiler/gcc: Raise minimum GCC version for kernel builds to 4.8
Date: Tue, 26 May 2020 16:57:07 -0500
Message-ID: <04ca01d633a8$9abb8070$d0328150$@codeaurora.org>
References: <20200526153004.GA74229@roeck-us.net> <CAKwvOdnrsCCt_HU+fows6kBCs2jGcikDtMm_otQSKFEgqfojJw@mail.gmail.com>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590530231; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=Lx+JlsYWqs8sfPrQRTmH7W6Ju5CUj4LarP9b9J9tMIM=; b=OhiFuqL884sUy4VJsoO6MwbcPoU6ckp5T9xSYQBue688BgQhAY2/EzQu9ubxbj2MV0I+ng6L
 hywkEjsXWdgRxYfNZAiAHy79Dk0tgnjMxwqcWKaUidIxvEYVvI6hBdYVJkdAj7ydsZIewvrU
 zAlRLVGVuPaEU4moWtHX2HHRR/c=
In-Reply-To: <CAKwvOdnrsCCt_HU+fows6kBCs2jGcikDtMm_otQSKFEgqfojJw@mail.gmail.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Nick Desaulniers' <ndesaulniers@google.com>, 'Guenter Roeck' <linux@roeck-us.net>
Cc: 'Will Deacon' <will@kernel.org>, linux-hexagon@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Masahiro Yamada' <masahiroy@kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Arnd Bergmann' <arnd@arndb.de>, sidneym@codeaurora.org

> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> owner@vger.kernel.org> On Behalf Of Nick Desaulniers
...
> On Tue, May 26, 2020 at 8:30 AM Guenter Roeck <linux@roeck-us.net> =
wrote:
> >
> > On Mon, May 11, 2020 at 09:41:37PM +0100, Will Deacon wrote:
> > > It is very rare to see versions of GCC prior to 4.8 being used to
> > > build the mainline kernel. These old compilers are also known to
> > > have codegen issues which can lead to silent miscompilation:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D58145
> > >
> > > Raise the minimum GCC version to 4.8 for building the kernel and
> > > remove some tautological Kconfig dependencies as a consequence.
> >
> > My hexagon compiler is v4.6.1, and I have been unable to find a more
> > recent version. Does anyone happen to have a pointer to a hexagon
> > toolchain with gcc 4.8 or later ?
>=20
> IIUC, hexagon moved to LLVM, though that target still has issues =
building the
> kernel.
> =
https://github.com/ClangBuiltLinux/linux/issues?q=3Dis%3Aopen+is%3Aissue+=
lab
> el%3A%22%5BARCH%5D+hexagon%22

Indeed, we did move to llvm.  The build works with the clang_rt-builtins =
lib.  But that issue indicates that it's an unnecessary wart to require =
that.  From what I understand, other arches contribute these builtins =
content to the kernel build, so we'll do the same.

I'll prioritize this update.

-Brian

