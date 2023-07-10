From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 4/4] vgacon, arch/*: remove unused screen_info definitions
Date: Sun, 9 Jul 2023 21:08:03 -0700
Message-ID: <CAMo8BfLOYkdxF4x=E2L4OYavw+GDtO0ftdAxCaVuFwGr=RUCyw@mail.gmail.com>
References: <20230707095415.1449376-1-arnd@kernel.org> <20230707095415.1449376-4-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688962094; x=1691554094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI9RNcelEJRqjgZ3cj4A/MldUxL+d7rqihkZbBH1AFY=;
        b=iVKpTnqvNrUhmIj8Pead4qxzUx+5FEqEj2o2LZQPy/bO+4COQLAPUA2tYXOc/R2BgT
         WXXxngVaWFUrztbY3CREIS4d8vXvIbEUHInTqWO8/fcCVi/k61dqCs9L57T6/hQPeoTL
         djqWGsASDlN37qpDOunajF78cc7Miv4m5fR9daAJazyNoH/Jv0IoP4QuI8R0xXektt0Z
         BzUZmv9QLZnpwucS2nyyz/xwdmr7pR9/9w8M76YZcl6WiWHbfX6msKl+3Dl0nSAnHW2A
         n70RJ3CEVgoCVyWZRzjwy1vt9eb2l4ZKA4WC/qtPMPfB6EBkvQiU2qne580vUi/Mhbov
         qXsw==
In-Reply-To: <20230707095415.1449376-4-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Masahiro Yamada <masahiroy@kernel.org>, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

On Fri, Jul 7, 2023 at 2:56=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> A number of architectures either kept the screen_info definition for
> historical purposes as it used to be required by the generic VT code, or
> they copied it from another architecture in order to build the VGA
> console driver in an allmodconfig build.
>
> Now that vgacon no longer builds on these architectures, remove the
> stale definitions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/kernel/setup.c          | 12 ------------
>  arch/hexagon/kernel/Makefile      |  2 --
>  arch/hexagon/kernel/screen_info.c |  3 ---
>  arch/nios2/kernel/setup.c         |  5 -----
>  arch/sh/kernel/setup.c            |  5 -----
>  arch/sparc/kernel/setup_32.c      | 13 -------------
>  arch/sparc/kernel/setup_64.c      | 13 -------------
>  arch/xtensa/kernel/setup.c        | 12 ------------

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
