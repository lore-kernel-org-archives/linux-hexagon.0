From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/9] vgacon: rework Kconfig dependencies
Date: Fri, 21 Jul 2023 14:59:24 +1000
Message-ID: <87pm4lj1w3.fsf@mail.lhotse>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-2-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1689915579;
        bh=E8y/g9Khd0fFkgBzOo2hgfNC9FxKvpUwWSNkgdFASms=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Vz9fUc/RXTu27vyeQvrCGoaE8JdmFqjso1U7IKft3F4+AMIPMbJxbd6+vpUogCok2
         jjqvREfJvYqz3QSGYRTfM9NbVcZw6ETTGk+G5ORy8Ef27KmVipGpAru/++iMcP0ZIY
         irL63A70ZpZtpSAA842FIXFsBi3K9pkiGHMiMA9uGES1k6AQTlIav7DvOXvaXW5lr1
         +C0AtN1LzNzfZWs6cqLKzQSLR9CakXGeTo5RmwHO24fURCoJ28UFMNlTF5RfwYFygo
         JIBkIXyWk0zwzOR6aKsdnuJSg4XvmCPd8c6HNDSu/dKGG51lsM7dl8r9XMYvtkwX6A
         gBrLXrGghZj8Q==
In-Reply-To: <20230719123944.3438363-2-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guo Ren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu->

Arnd Bergmann <arnd@kernel.org> writes:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The list of dependencies here is phrased as an opt-out, but this is missing
> a lot of architectures that don't actually support VGA consoles, and some
> of the entries are stale:
>
>  - powerpc used to support VGA consoles in the old arch/ppc codebase, but
>    the merged arch/powerpc never did

Not disputing this, but how did you come to that conclusion? I grepped
around and couldn't convince myself whether it can work on powerpc or
not. ie. currently it's possible to enable CONFIG_VGA_CONSOLE and
powerpc does have a struct screen_info defined which seems like it would
allow vgacon_startup() to complete.

My only concern is that someone could be using it with Qemu?

cheers
