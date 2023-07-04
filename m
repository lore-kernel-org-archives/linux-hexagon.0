From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 04/12] staging/sm750fb: Do not include
 <linux/screen_info.h>
Date: Tue, 04 Jul 2023 18:27:01 +0200
Message-ID: <87a5wblk16.fsf@minerva.mail-host-address-is-not-set>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-5-tzimmermann@suse.de>
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
	List-Owner; bh=qptQ7k72PeOlrWpxWEqPW4/R9AnrczAbf5hadBQ1KwM=; b=hrEoj3YxXPn2RW
	HaPzzGAa+CLaxshnXOwseXQdwiioDqqwJm6YU7zXgFPhr3a9g16N6w8ZiLyUEJx6w15dFCAITAV7V
	XR0KTX0OY77w87nWPOklLPl46D4RvYNqMeekNvnYG95NgYXFwow7IhEYkwxnjlQML3wtAeS2ZxWmR
	noFPK3chq1+0aylto132GYXVaq0vsfxu65xv9OaNH9IQIONt9/HDwckFOms4KWWWOBAXhDyQE0sGT
	Ie/CX4Z1PUu/w6uTWgl4WZtX1/R0maBWnPJAd/L3AD4gnZYiwv+QsLmNHgoiPQ4hlwAEJifqLt+Nm
	b4KbOTvutEjUGgSGM56w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688488025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4kQnHD6yHzrEv/r8EzHQhBzLicpYH1qRl0henJBZG6I=;
	b=Sosg1f596cxBf/cRddM2ban7iErXisx9K0oEmVEUG9IKKw2UPTtpFnxFcQJZB274k10qAm
	Qic6jAN2kncK7el8ljFxzr8xy/6SK+Yxg2O9sw6aNT1MUDJvHIRuuqfBvoX372lSwvMh+n
	RHif54X2yCo9K/dSz80Ab3PUAgHVE9I=
In-Reply-To: <20230629121952.10559-5-tzimmermann@suse.de>
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

> The sm750fb driver does not need anything from <linux/screen_info.h>.
> Remove the include statements.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat
