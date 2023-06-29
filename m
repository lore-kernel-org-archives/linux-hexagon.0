From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
Date: Thu, 29 Jun 2023 15:21:39 +0200
Message-ID: <0dbbdfc4-0e91-4be4-9ca0-d8ba6f18453d@app.fastmail.com>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-8-tzimmermann@suse.de>
 <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
 <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688044920; x=1688052120; bh=sQ
        O+tpzU86Ruad95sakzckO3PnIV53aaJirVNNGwiuo=; b=4uqnQG/Z1UuyNyyAek
        0XEemltl5YoKfbuyK7idzOfGbk2sj8tW5sPhftwy7vAcMTe/lNT1CqLxPHHTqxXl
        b+N4aIXSme583rtEDLHRQQE5RZfTFsD+lTdYY9RefCbOfAlhciUTlKT5u2JXw4I4
        ztOXsWSrHvNADHnJ68PH1ClsbIkWEIcWMVseJvPUcBCt/bCpX9x+rZSZZO6oAAQb
        x9SWYdHJXxBC2SICSWUYB8JczQyliaPFo8FiWTtVLKrXWw/KnLs9i/+IAnqxZm8k
        yqkPPTEwfMl+/IelpxRjc4jeyf7SfLboZoIPnpuMmrGUGm6Jvxy4MC7RByrwgGdC
        yACQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688044920; x=1688052120; bh=sQO+tpzU86Rua
        d95sakzckO3PnIV53aaJirVNNGwiuo=; b=IbgfMem7uDuQxpPEGhflBncHobvLW
        vpdJgB9HlfrxSWZohr0Jpjmu+TTjCXIaQB0uQ+13MlfVT0itNPNX4vwmIqNieKC6
        gPv4iflQLslU6lXHYDAvAm799+KHkiXlvXfZM777AHY2iwxEls+3U9z2bO1yeOef
        wFpfTxWZmsHuvogMZSyJmnFyjemy8yi74cXqbPUy2ZTBAZ4KqNqWtoYlOjGYmlQy
        PMPbNhtV1XvXdYg2lSN5WBQIEaNfObSZgMdkW8nfVQEunQCLpApHo/cwzRobpAQN
        ZuHALvp9USqwqc7dcNooNTZaYpKwAFukGjJYFDScEYkfK4BGpwxbvs5wA==
In-Reply-To: <d3de124c-6aa8-e930-e238-7bd6dd7929a6@suse.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, K

On Thu, Jun 29, 2023, at 15:01, Thomas Zimmermann wrote:
> Am 29.06.23 um 14:35 schrieb Arnd Bergmann:
>> On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:
>>> The global variable edid_info contains the firmware's EDID information
>>> as an extension to the regular screen_info on x86. Therefore move it to
>>> <asm/screen_info.h>.
>>>
>>> Add the Kconfig token ARCH_HAS_EDID_INFO to guard against access on
>>> architectures that don't provide edid_info. Select it on x86.
>> 
>> I'm not sure we need another symbol in addition to
>> CONFIG_FIRMWARE_EDID. Since all the code behind that
>> existing symbol is also x86 specific, would it be enough
>> to just add either 'depends on X86' or 'depends on X86 ||
>> COMPILE_TEST' there?
>
> FIRMWARE_EDID is a user-selectable feature, while ARCH_HAS_EDID_INFO 
> announces an architecture feature. They do different things.

I still have trouble seeing the difference.

> Right now, ARCH_HAS_EDID_INFO only works on the old BIOS-based VESA 
> systems. In the future, I want to add support for EDID data from EFI and 
> OF as well. It would be stored in edid_info. I assume that the new 
> symbol will become useful then.

I don't see why an OF based system would have the same limitation
as legacy BIOS with supporting only a single monitor, if we need
to have a generic representation of EDID data in DT, that would
probably be in a per device property anyway.

I suppose you could use FIRMWARE_EDID on EFI or OF systems without
the need for a global edid_info structure, but that would not
share any code with the current fb_firmware_edid() function.

     Arnd
