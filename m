From: Nick Kossifidis <mick@ics.forth.gr>
Subject: Re: [PATCH v3 11/17] riscv: Convert to GENERIC_CMDLINE
Date: Tue, 30 Mar 2021 03:52:17 +0300
Message-ID: <3ae0c2faa08f76efb8a446f262b712df@mailhost.ics.forth.gr>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
 <87zgyqdn3d.fsf@igel.home> <81a7e63f-57d4-5c81-acc5-35278fe5bb04@csgroup.eu>
 <CAL_JsqK2TT=j1QjiRgTYQvwHqivE-3HgYo2JzxTJSWO2wvK69Q@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1617065539; x=1619657539;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4Ytp87wkA+alvM5YO/7dlXgP5/jZJBWXepwASfozGUU=;
        b=CXdKG8AeuRZiwZ+qSuU9itQVeS+S6jzZD+LSRTjBq4uIMwy1EtYl2LFohFQ3P0aL
        1snhQLBfGMnJPLlMUvta1R1ExG60xpMGjvqAzE108mPHfXrfMlKUizgfR2G3CWnj
        dKei0YP7+vI+q9xmsTyWmdWtYdS0hBwgkfMMp+y/DHsFRhQlCWvNoRqg2neDGsDy
        A/MbNsCxbPucEdxZvgGboLEud/obw/iKdEC8cDqcfAJRCeFRpho58PpEswmR8XMQ
        DBZlttMlmL7pkMgUDfZroBTVf9b7EC2+ikG/v595zLMuOGi 
In-Reply-To: <CAL_JsqK2TT=j1QjiRgTYQvwHqivE-3HgYo2JzxTJSWO2wvK69Q@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Rob Herring <robh@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Andreas Schwab <schwab@linux-m68k.org>, Will Deacon <will@kernel.org>, Daniel Walker <danielwa@cisco.com>, Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, microblaze <monstr@monstr.eu>, "open list:MIPS" <linux-mips@vger.kernel.org>, nios2 <ley.foon.tan@intel.com>, Openrisc <openrisc@lists.librecores.org>, linux-hexagon@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, X86 ML <x86@kernel.org>, linux-xtensa@linux-xtensa.org, SH-Linux <linux-sh@vg>

Στις 2021-03-26 17:26, Rob Herring έγραψε:
> On Fri, Mar 26, 2021 at 8:20 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>> 
>> 
>> 
>> Le 26/03/2021 à 15:08, Andreas Schwab a écrit :
>> > On Mär 26 2021, Christophe Leroy wrote:
>> >
>> >> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> >> index f8f15332caa2..e7c91ee478d1 100644
>> >> --- a/arch/riscv/kernel/setup.c
>> >> +++ b/arch/riscv/kernel/setup.c
>> >> @@ -20,6 +20,7 @@
>> >>   #include <linux/swiotlb.h>
>> >>   #include <linux/smp.h>
>> >>   #include <linux/efi.h>
>> >> +#include <linux/cmdline.h>
>> >>
>> >>   #include <asm/cpu_ops.h>
>> >>   #include <asm/early_ioremap.h>
>> >> @@ -228,10 +229,8 @@ static void __init parse_dtb(void)
>> >>      }
>> >>
>> >>      pr_err("No DTB passed to the kernel\n");
>> >> -#ifdef CONFIG_CMDLINE_FORCE
>> >> -    strlcpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>> >> +    cmdline_build(boot_command_line, NULL, COMMAND_LINE_SIZE);
>> >>      pr_info("Forcing kernel command line to: %s\n", boot_command_line);
>> >
>> > Shouldn't that message become conditional in some way?
>> >
>> 
>> You are right, I did something similar on ARM but looks like I missed 
>> it on RISCV.
> 
> How is this hunk even useful? Under what conditions can you boot
> without a DTB? Even with a built-in DTB, the DT cmdline handling would
> be called.
> 
> Rob
> 

cced Paul who introduced this:
https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/arch/riscv/kernel/setup.c?id=8fd6e05c7463b635e51ec7df0a1858c1b5a6e350

