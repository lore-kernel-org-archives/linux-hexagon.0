From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 35/44] m68k: Register with kernel poweroff handler
Date: Tue, 7 Oct 2014 11:19:36 +0200
Message-ID: <CAMuHMdVZmsjK9FdK0T6mWwrnNc=Xc97B7ynm+QbWUMBCnvQB_g@mail.gmail.com>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
	<1412659726-29957-36-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=3bI5zwPc81h9QH8a5IVnm+hmZu7byYq4VebIe/T6rTM=;
        b=a4/Y310k8Eq5hIttT3kqJDAxWLGNuUSbJiMHAOAxRxi6hm2EyhHkQgDQc0Hn+G/nWJ
         FHE7P4fD9RZqzNcLlZCEvS2Z93GSKUT2lYyKufbM1UAwvdpq1VaAczskBRD96n8rdBo3
         HEhsPAMi/uYdGKcrP+XYJj0Mz5Pz6dDZPSYCXllbj+ZsKf4qoBJnBrub4XbqfbeBVwdb
         zasBOEgdpcFPPQCIzDQjSzobOGtdKcJKtWfms9Smbc4/4yY5GEBey5kJIMtnudUg6JT4
         KBpNXu2yUb2O0plCGJnuzBMZUBkuFC6EGDO1owVZ9bGcNVijFTmN806jzaqyzswv0NKt
         xW4Q==
In-Reply-To: <1412659726-29957-36-git-send-email-linux@roeck-us.net>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, driverdevel <devel@driverdev.osuosl.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lguest@lists.ozlabs.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>, Cris <linux-cris-kernel@axis.com>, linux-efi@vger.kernel.org, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-m32r-ja@ml.linux-m32r.org, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-tegra@vger.kernel.org, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, openipmi-developer@lists.sourceforge.net, uml-devel <user-mode-linux-devel@lists.s>

On Tue, Oct 7, 2014 at 7:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Joshua Thompson <funaho@jurai.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

As someone already mentioned, having #defines instead of hardcoded
numbers for the priorities would be nice.

Apart from that:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> +       register_poweroff_handler_simple(nf_poweroff, 128);

> +       register_poweroff_handler_simple(mac_poweroff, 128);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
