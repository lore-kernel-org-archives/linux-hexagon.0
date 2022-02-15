From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 08/14] arm64: simplify access_ok()
Date: Tue, 15 Feb 2022 10:39:46 +0100
Message-ID: <CAK8P3a0NTqK_m7q909d8FN6is8k4_u3zeckC9XOrjEi7kqSvmg@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
 <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com> <CAMj1kXGkG0KMD2rnKAJc3V7X9LP1grbcHTNYMnj_q4GiYfG2pQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644918004;
        bh=hv8AUuEMkapI1zY2x6Wj+fHd7ew8TaKYgsOBPTPrxmw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qgz5FlPpKWsWGCSKlOreQeA49RzB47Yb61DpdQGkSqCvpQXhd/1xrVzA6HxgVkOAv
         HM/bWEouCkOrFRfLVSWs2TAF8Lvnm82Q7ljXZwaQBoSUgr63Phu8Xh5sdVnTyJI/ON
         lHIubRtLqY287IV/RrnG/iEcxILMQsa62F1uuyYy08GpnMfCYeG+01yyQZZn7UnJv7
         021LqbfWi1zld4k8/8Wmx6fnGfR5no+iR4l8Y+N7e700ePaO67g4IaN0y0Orgs7STR
         gYOAdpNAvnxBHFJPJ1WrXSLgaxHaPAb+pRZVWsShzWY/LNUX3cgIy9+U52JoF4j03G
         HEN4j4yjmnzVQ==
In-Reply-To: <CAMj1kXGkG0KMD2rnKAJc3V7X9LP1grbcHTNYMnj_q4GiYfG2pQ@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@eller>

On Tue, Feb 15, 2022 at 10:21 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Tue, 15 Feb 2022 at 10:13, Arnd Bergmann <arnd@kernel.org> wrote:
>
> arm64 also has this leading up to the range check, and I think we'd no
> longer need it:
>
>     if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
>         (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
>             addr = untagged_addr(addr);

I suspect the expensive part here is checking the two flags, as untagged_addr()
seems to always just add a sbfx instruction. Would this work?

#ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
#define access_ok(ptr, size) __access_ok(untagged_addr(ptr), (size))
#else // the else path is the default, this can be left out.
#define access_ok(ptr, size) __access_ok((ptr), (size))
#endif

       Arnd
