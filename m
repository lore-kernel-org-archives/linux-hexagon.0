From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 02/12] fbdev/sm712fb: Do not include <linux/screen_info.h>
Date: Tue, 04 Jul 2023 18:25:39 +0200
Message-ID: <87fs63lk3g.fsf@minerva.mail-host-address-is-not-set>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-3-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A6KAL3aGVZdJ3Ra6fVaKjExo8B2srDMzXIDMe0buUps=; b=p+Abin+fV4zKYL
	AAaenoO9+FYRGj3z3vQupKJG6x9Pu7E0tAxSDfmfvqmiKLfvBSSc05bVHhh0peImTgDyAuWzPnV9G
	cQ4dkQ7eamxr0hpvhq/wEyG4n8ZIkKDq2xzs0/yFtmfHupb4xPZ2mlb9qkgXTcVAIQjYgNfrJRqai
	scoHVR7qiz/XuP1HZK1C35ac4lcFHvTc6iXYjx+v5ZBE17NgX1oXKACiPQo9wetfXTyaGmbd4nPWd
	0fwe0kNfsPgt8KkaUnsmdiuDRiH4HI9qXghGnWBmUDWA39r1+xxvJBL25oZKCrk/TDckd/zINdpgP
	7AoKxbsALafd3aOWKF9Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688487944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M8/mkORscNjCU/dvtXt+o+8I4w7Qa8785g4rCe6dq88=;
	b=hvTBd4/dcOgnInwoXXiTNcED5D6tWe1cril3AjgdSxq5v1+f1uQCTxq+h/PtzFG2y6Bzu5
	xHM3LEZhYx1uxbdO85WODDGnuBzv+J+M6ZaaMzsH/Lc6Ez28QD++wAJKL4tAUZ8wXynlgj
	gf45QZbfvxcfevj+TRxBhiq6GhqfaVU=
In-Reply-To: <20230629121952.10559-3-tzimmermann@suse.de>
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
To: Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, loongarch@lists.linux.dev, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-arm-kernel@lists.infradead.org, Teddy Wang <teddy.wang@siliconmotion.com>

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Sm712fb's dependency on <linux/screen_info.h> is artificial in that
> it only uses struct screen_info for its internals. Replace the use of
> struct screen_info with a custom data structure and remove the include
> of <linux/screen_info.h>.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> Cc: Helge Deller <deller@gmx.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat
