From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v6 1/1] cmdline: Add capability to both append and
 prepend at the same time
Date: Thu, 8 Apr 2021 15:08:00 -0500
Message-ID: <CAL_JsqJ=UNfptbNHR5XAS9BQRv3C5+YonW9rwypA5gGt2N7bGQ@mail.gmail.com>
References: <34d20d1dbb88f26d418b33985557b0475374a1a5.1617556785.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617912493;
        bh=lJBvFSudiDrxZs+SnGh4YtxaarzP38H043H9PsxfbKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tBubWWY3+neAkzvUwVEoCp09FqswXCDaRx0c5tqpOKjvcYtVCmFe8JHZ54TSymAUN
         LcUpHK9kiXHWgsLiDmBkRkBjUyBdxgg10Kg/vhYMlvwhM6Td33Bu/fEAPoZH7Rwzg3
         y/02Yh1kIkod5A/25l6gmVy/uGkdg25wTAzvSArNYFnlkxuDzKdqut3U9ckR8RDs9P
         vDjyKsx0P5LjQjJsrua6oISbMFMHmtnTHx3DuSW049FdIe7WaniCJJy7rcIwUJrymm
         s/dYmx64TzuZ1Bdy4C5SW9baPR3AZmbYAPa+qWcEfy3HARHgLptgEEwfQza7x3mWiq
         CQZwA4HwhhFsA==
In-Reply-To: <34d20d1dbb88f26d418b33985557b0475374a1a5.1617556785.git.christophe.leroy@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Will Deacon <will@kernel.org>, Daniel Walker <danielwa@cisco.com>, Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>, Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, microblaze <monstr@monstr.eu>, "open list:MIPS" <linux-mips@vger.kernel.org>, nios2 <ley.foon.tan@intel.com>, Openrisc <openrisc@lists.librecores.org>, linux-hexagon@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org, SH-Linux

On Sun, Apr 4, 2021 at 12:20 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> One user has expressed the need to both append and prepend some
> built-in parameters to the command line provided by the bootloader.
>
> Allthough it is a corner case, it is easy to implement so let's do it.
>
> When the user chooses to prepend the bootloader provided command line
> with the built-in command line, he is offered the possibility to enter
> an additionnal built-in command line to be appended after the
> bootloader provided command line.
>
> It is a complementary feature which has no impact on the already
> existing ones and/or the existing defconfig.
>
> Suggested-by: Daniel Walker <danielwa@cisco.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Sending this out as an RFC, applies on top of the series
> ("Implement GENERIC_CMDLINE"). I will add it to the series next spin
> unless someone is against it.

Well, it works, but you are working around the existing kconfig and
the result is not great. You'd never design it this way.

Rob
