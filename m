From: Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 10/12] fbdev/core: Use fb_is_primary_device() in
 fb_firmware_edid()
Date: Wed, 05 Jul 2023 10:02:27 +0200
Message-ID: <878rbuss4s.fsf@minerva.mail-host-address-is-not-set>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-11-tzimmermann@suse.de>
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
	List-Owner; bh=ZU86etC5wvgrH1btWnp5yW8cFn3bAVdVpxSqom4oBuQ=; b=NxU6eaNCZOx6pP
	+gr5aK8Egt62OB3DG73OY94XTc942luidwWezq87AyDzmOyeoNWqZISI7srtDx1LzW4J3gcXONhOn
	+lc6v8ZupdB2gEaz4S771iD9vlMnJkpHVVtDD7tvlQkIAhHqvpLMrQfEqenHhOmqMvRltixvxBh2b
	k6c9WlqoDAK+AufVUAyoSJTXXzLzIn5keVG59WlT8BA7AC8427TaI69cSSaTErlOeS8V/+GZqjEH1
	C6/zjiiYeSYPDgZq88T9/lNwx1l1WlZyTtLavwALv+IrPTk5PMfN8Gh2rDfw0I3EntEQwbDOx8PQs
	+P96EtQ8UkpA6KLCXRpQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688544151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XDgcQtPSCk85F9YjOuVpAuyCl327gSG/7+9nyPHiobU=;
	b=HVNH53ZDOszA2ZQz3FXyXsIdeqgezqU0uNVYe9yOyAHL6wluM2dvAM16LhKgyJWDFGOQmn
	tb2JRp6RWWHzNzPXI9PkC+ELtVg840KchYLERyVasoxVVEy+OMxCArJ6ecJOa0Aa21JF+6
	cOz8UIM1odQz1gioutujRaqMF28O6Tc=
In-Reply-To: <20230629121952.10559-11-tzimmermann@suse.de>
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
Cc: linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev, linux-csky@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>, Maik Broemme <mbroemme@libmpq.org>, loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Detect the primary VGA device with fb_is_primary_device() in the
> implementation of fb_firmware_edid(). Remove the existing code.
>

An explanation about why this is possible would be useful here.

> Adapt the function to receive an instance of struct fb_info and
> update all callers.
>

[...]

> -const unsigned char *fb_firmware_edid(struct device *device)
> +const unsigned char *fb_firmware_edid(struct fb_info *info)
>  {
> -	struct pci_dev *dev = NULL;
> -	struct resource *res = NULL;
>  	unsigned char *edid = NULL;
>  
> -	if (device)
> -		dev = to_pci_dev(device);
> -
> -	if (dev)
> -		res = &dev->resource[PCI_ROM_RESOURCE];
> -
> -	if (res && res->flags & IORESOURCE_ROM_SHADOW)

This open codes what used to be the fb_is_primary_device() logic before
commit 5ca1479cd35d ("fbdev: Simplify fb_is_primary_device for x86").
But now after that commit there is functional change since the ROM
shadowing check would be dropped.

I believe that's OK and Sima explains in their commit message that
vga_default_device() should be enough and the check is redundant.

Still, I think that this change should be documented in your commit
message. 

With that change,

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat
