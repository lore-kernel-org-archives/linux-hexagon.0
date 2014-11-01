From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 33/44] avr32: atngw100: Register with kernel poweroff
 handler
Date: Sat, 01 Nov 2014 10:02:58 -0700
Message-ID: <54551242.2020604@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net> <1412659726-29957-34-git-send-email-linux@roeck-us.net> <20141101101637.GA5765@samfundet.no>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=+vyobUtl6o+NbWxalKaZXZhrn9jkKWElOVIpoJS9yKM=;
	b=8HYClz2bG/I0l/otDvrmOcGtvH5W9XibcmFaeK9mu2Zv6n2jvucdVZJclrw+8pZdCXnHgzj34agQymeZBNwQcQnipk6PgXc57W9e/L6rBQZOJgSPNIzNlth5+oIJUp8OINfG4R14DueHoHKH/ti7UbmdXYXgZTmdn9LT4KWvnmg=;
In-Reply-To: <20141101101637.GA5765@samfundet.no>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: linux-kernel@vger.kernel.org, adi-buildroot-devel@lists.sourceforge.net, devel@driverdev.osuosl.org, devicetree@vger.kernel.org, lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, linux-am33-list@redhat.com, linux-cris-kernel@axis.com, linux-efi@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org, openipmi-developer@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org, Haavard

On 11/01/2014 03:16 AM, Hans-Christian Egtvedt wrote:
> Around Mon 06 Oct 2014 22:28:35 -0700 or thereabout, Guenter Roeck wrote:
>> Register with kernel poweroff handler instead of setting pm_power_off
>> directly.
>>
>> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
>> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>

Thanks!

Guenter

