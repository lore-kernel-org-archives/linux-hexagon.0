From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 0/9] video: screen_info cleanups
Date: Wed, 19 Jul 2023 16:57:30 +0200
Message-ID: <6c9be40f-0970-3eb5-899f-b69aa09d7f97@gmx.de>
References: <20230719123944.3438363-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZsnXQQuz7YmDyKHS3uIp8bhrTAyTzEBYng5KUz9MjlM=; b=G0zCPAKrBV8MHu
	KOqW7zqMkpmXrjzKljz8DmyF29gLSQ3p6mDRMYWDfEYTSwQVNujDhsid+Q56j1lo7zaLOGcUcHlw3
	/8gHvdvHuDg979TO6QXDPY6x/oU97M9zmQN0YDys9Hz/bIFJ0etqzpXgzXsiT+ZejM9/3RmCfoZmj
	+W5hpnIYBx2HBHSiHHbrFwN34bI54MznO9hpWX3la4GxUzY5fM94wLWHTBUrttDPnlUyLdIcnuRSY
	j+XliF9K9VqY3G6ZzGryXOoB0/obhqleN7rSh3uEAnEBuTrvBPAGlOu0dIqsXNiSM1v+8DlUsAGRV
	sjTVUbWG1j/Xg4QvACqg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689778659; x=1690383459; i=deller@gmx.de;
 bh=iQUnHGbic8gu+ig2/dvuRMVZ9NdHOWOrYR1bIcIdEEI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Oj76ZDbvIWlVeT7RknkMQBRZveyGPeaavM/7Hd2yo0VaxgBreq1RYAEB0hFfewqVvvghv6Q
 bodOrVr550D5HZlqDgB3YLfPOrTCQM3TCjKHDB2dJOZHoIa71786MQxwB1NbvycigzSKOxAXb
 6ZzEXcDb9k3UgAEfth7TfHSLA58vvfzUv6ulGW71L5xNw0gixI8MKF5gnbT3fhbWS+ATeYNKt
 ieCK2TFKuSXE/ozWDwJJy++aTZ0SBnrY/ovnKdb81Uk7xmvoS7C6bZynPoMyxlk0tyc4eBPNb
 ugz85t+iHLpPDHwe2/OJ0aXdRz0Qd8Wj5Gm6vVqKd6ptYS3WJ2ZA==
Content-Language: en-US
In-Reply-To: <20230719123944.3438363-1-arnd@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guo Ren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Khalid Aziz <khalid@gonehiking.org>, Linus Walleij <linus.walleij@linaro.org>, Matt Turner <mattst88@gmail.com>, Max

On 7/19/23 14:39, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> I refreshed the first four patches that I sent before with very minor
> updates, and then added some more to further disaggregate the use
> of screen_info:
>
>   - I found that powerpc wasn't using vga16fb any more
>
>   - vgacon can be almost entirely separated from the global
>     screen_info, except on x86
>
>   - similarly, the EFI framebuffer initialization can be
>     kept separate, except on x86.

Nice cleanup, Arnd!

You may add a
Acked-by: Helge Deller <deller@gmx.de>
to the series.


> I did extensive build testing on arm/arm64/x86 and the normal built bot
> testing for the other architectures.

> Which tree should this get merged through?

I suggest drm-misc or fbdev. Either is fine for me.

Since it applies cleanly onto git head, I can put it a few days into
the fbdev git tree to see if some builds break. Just let me know.

Helge
