From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH v2 1/9] vgacon: rework Kconfig dependencies
Date: Fri, 21 Jul 2023 10:26:30 +0200
Message-ID: <19631e74-415e-4dcb-b79d-33dcf03d2dfc@app.fastmail.com>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-2-arnd@kernel.org> <87pm4lj1w3.fsf@mail.lhotse>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689928040; x=1690014440; bh=V8
        kkxioRFPjR/pcGqI7bYcicee1af9QaKC3pDwPABSg=; b=cSu25aofj3k78Gwvjn
        AeApNXcPQ4m0EkJR+F/FR6X0iWUO4WSNdIIXBNu9IuKLJRziOlSFRwDBU8XHxTAZ
        qFvfpzf6Fqcsui64BX/auOaUT8DpTf55Um6d6mIrhtX90E7pAWUkD4FxYpYGJo3R
        cJ23vzSYXksDNzV5a5SVkd3auBPf4sTFsIbC5WfiZtnbkhUaTGjWxwHEZjc5dj4Z
        ExxSxCQnOdr8Nh2a8NO8ayVRWbjLPzFLtRExpI2Wkb9vg6QauJCHb4+5i+FSpnXM
        r/zD/innoFirhLlgq9POHdmFW+DsxQzLUq4o9sf1LEqMG3qLnDEwxNS26mrQY/3k
        za2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689928040; x=1690014440; bh=V8kkxioRFPjR/
        pcGqI7bYcicee1af9QaKC3pDwPABSg=; b=JLTw/YwFC4sBp4eez9+aKjZwfdUxH
        oR/mZBQ+L1gJ4Cpfz1EgHzlgGEdvDo1MQAN2+5JUTAP9maAMGaPzy4rh/1QP/gr2
        i3AVkB7R92HU90NWLS3VB4VHT3pu4ItP6yrpMz949odIs4AiptZGzzPE5Jyf/oUP
        8RHnAj5WamxgQToMEXU+DdHI2Wgd+dn4kyMrYsuhj6H/9TK7zBBNpZ5l67fbVHG8
        chitq7Y51/9QRvvtx52pkfeh9rKiXrGsRxKVZ0iUK3MGBTXtds+sd+526B6ccQvb
        E5dGv4p2vxusjFWvSyTWybP4Ci3VfrkuumVEROmmRFBnEf3CI0ZkrLLag==
In-Reply-To: <87pm4lj1w3.fsf@mail.lhotse>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, guoren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.d>

On Fri, Jul 21, 2023, at 06:59, Michael Ellerman wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The list of dependencies here is phrased as an opt-out, but this is missing
>> a lot of architectures that don't actually support VGA consoles, and some
>> of the entries are stale:
>>
>>  - powerpc used to support VGA consoles in the old arch/ppc codebase, but
>>    the merged arch/powerpc never did
>
> Not disputing this, but how did you come to that conclusion? I grepped
> around and couldn't convince myself whether it can work on powerpc or
> not. ie. currently it's possible to enable CONFIG_VGA_CONSOLE and
> powerpc does have a struct screen_info defined which seems like it would
> allow vgacon_startup() to complete.

The VGA console needs both screen_info and vga_con to work. In arch/ppc
we had both, but in arch/powerpc we only retained the screen_info:

$ git grep vga_con v2.6.26 -- arch/ppc arch/ppc64 arch/powerpc
v2.6.26:arch/ppc/platforms/pplus.c:     conswitchp = &vga_con;
v2.6.26:arch/ppc/platforms/prep_setup.c:        conswitchp = &vga_con;

so after arch/ppc was removed, this became impossible to use on both
pplus and prep. These two platforms were also (as far as I can tell)
the only ones to support vga16fb as an alternative to vgacon, but
both platforms were removed later on.

> My only concern is that someone could be using it with Qemu?

I have not yet ruled out anyone using vga16fb on qemu before
commit 0db5b61e0dc07 ("fbdev/vga16fb: Create EGA/VGA devices
in sysfb code"), but I can see that this has been broken for
12 months without anyone complaining about it, since vga16fb
no longer works with the "orig_video_isVGA == 1" setting
in arch/powerpc (the device is not created).

In the qemu sources, I see five powerpc machines that intialize
VGA support: mac_newworld, mac_oldworld, pegasos2, prep, and spapr.
I think we can exclude prep (which was removed from the kernel)
and spapr (64-bit VGA_MAP_MEM() looks broken). I think the
macs always come up in graphical mode and only use
offb/atifb/rivafb/matroxfb but not vga16fb that would require
running the x86 VGA BIOS initialization.

I suppose it's possible to use vga16fb (not vgacon) with
"qemu-system-ppc -M pegasos2 -vga std" if that still boots
at all. Support for pegasos2 hardware appears to have been
removed with commit 04debf21fa174 ("powerpc: Remove core
support for Marvell mv64x60 hostbridges"), but it's possible
that this did not break qemu support if that only uses
devices under arch/powerpc/platforms/chrp/pci.c. I could
not get it to boot, but did not try very hard.

      Arnd
