From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 00/12] arch,fbdev: Move screen_info into arch/
Date: Thu, 29 Jun 2023 15:31:28 +0200
Message-ID: <4d711508-c299-49f2-8691-e75d68f2485e@app.fastmail.com>
References: <20230629121952.10559-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wVpttqs9CI6QvCR4ig9lXKM0G8ZFilbWRayEnGksL80=; b=0fkx77Ay4NSUtg
	Y36iOANPmYxfWklbpkDrRpX0wTmgElqnwQe1G5Jn4EFAm5CdsnFqzJnGJZFHdoaX0lA/2qwntDuJJ
	Wrex8Hxf0VytXJdbw9oQzGDO597ag4cPQM4ONImmLpMpEALhURWRd2extpy+4iVzOj35xIfsEFmsT
	VMhnUbAzYiczms4J5kd9XydDh+T7glOf837fxe81ZP1+ePfSDoE3s+Ksi6Je0ovk4DWpZOcVtLff0
	qKqGdTosJvZk/W5+w5ysdXKCLURd/E/qAOCT8u4DxtD1iTryADBrKIvkVZ5v+66W6KA1SgISGPIFm
	GX+GW0TVyf6du/4XNN0Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1688045588; x=1688052788; bh=fz
	Ep5wc1N4xfnU7pMFQwstMWnCUW1KpffY9nt8n1q0E=; b=LcvTxzhqR3NoPlUVvK
	OSmh2HXq0TKY72TPC0mGFyZL0KXvjsqnUtwwDauvmZMJLb5NJHO5zC7uiIPaXimT
	gzsidicsFWLRov6t4tFnhjdpszLK6hNyyqPfbDn62gWWs0Kof8U6fw258RVzajax
	TvEI9fr4nmLUhZ9eWf5cl+Gznh5JCGNWo9vfb9WqVUcXA4M4zI8VmRSOc4Rpqa2j
	5ha9dObpeYiBRXh4uBF8Bo02V+0ZfPpN2oP/dF7iFMYdXyANDgvRcnqLaw0UQ7TO
	r1HYR4swvYxxa9cMKtxPWwjmkzaxBCii0Km30Ly6pgOJfleJm4wepJ/1GiUa/suS
	Y7xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1688045588; x=1688052788; bh=fzEp5wc1N4xfn
	U7pMFQwstMWnCUW1KpffY9nt8n1q0E=; b=fyh1ajjE7le9b8SLHXPaGdLDEYcOx
	QNrQVUJ3xaaQqLGBpnORFKOR91qIZo0pC/rbPTctQCecVgWTu8aWuxe/ayiMwhSL
	eDIob7sa1BmbCpUowwbQwkuGz16jQSanIvdHA2EF8BgyO4NL3hh0u77vR4TeuGFE
	rEtOhAHeEVwheX+0G+0z5POYm6ret69YXQ+gaXS7thrMG3c0vVj9IaYGsJsEflu+
	T4OjKxK0ew2/nKXrZblbKAcre4LFmDxtHNMO5w/ZzKHZCdES6wCDDurx5azbCNGj
	6s0XP9I64f1KhHJXsIN9/c95TfKYzHJGQZmAuCAxQNaTiAIrzIxu8sIYA==
In-Reply-To: <20230629121952.10559-1-tzimmermann@suse.de>
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
To: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-mips@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, loongarch@lists.linux.dev, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:
> The variables screen_info and edid_info provide information about
> the system's screen, and possibly EDID data of the connected display.
> Both are defined and set by architecture code. But both variables are
> declared in non-arch header files. Dependencies are at bease loosely
> tracked. To resolve this, move the global state screen_info and its
> companion edid_info into arch/. Only declare them on architectures
> that define them. List dependencies on the variables in the Kconfig
> files. Also clean up the callers.
>
> Patch 1 to 4 resolve a number of unnecessary include statements of
> <linux/screen_info.h>. The header should only be included in source
> files that access struct screen_info.
>
> Patches 5 to 7 move the declaration of screen_info and edid_info to
> <asm-generic/screen_info.h>. Architectures that provide either set
> a Kconfig token to enable them.
>
> Patches 8 to 9 make users of screen_info depend on the architecture's
> feature.
>
> Finally, patches 10 to 12 rework fbdev's handling of firmware EDID
> data to make use of existing helpers and the refactored edid_info.
>
> Tested on x86-64. Built for a variety of platforms.

This all looks like a nice cleanup!

> Future directions: with the patchset in place, it will become possible
> to provide screen_info and edid_info only if there are users. Some
> architectures do this by testing for CONFIG_VT, CONFIG_DUMMY_CONSOLE,
> etc. A more uniform approach would be nice. We should also attempt
> to minimize access to the global screen_info as much as possible. To
> do so, some drivers, such as efifb and vesafb, would require an update.
> The firmware's EDID data could possibly made available outside of fbdev.
> For example, the simpledrm and ofdrm drivers could provide such data
> to userspace compositors.

I suspect that most architectures that provide a screen_info only
have this in order to compile the framebuffer drivers, and provide
hardcoded data that does not even reflect any real hardware.

We can probably reduce the number of architectures that do this
a lot, especially if we get EFI out of the picture.

      Arnd
