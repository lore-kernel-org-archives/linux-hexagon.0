From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 07/12] arch/x86: Declare edid_info in <asm/screen_info.h>
Date: Thu, 29 Jun 2023 14:35:46 +0200
Message-ID: <80e3a583-805e-4e8f-a67b-ebe2e4b9a7e5@app.fastmail.com>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-8-tzimmermann@suse.de>
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
	List-Owner; bh=TQfJYKjFuTxBxFIcup163TdO5/H4oZgTTG6YYCHpg8U=; b=p307/ZaC1SZVHC
	s4fxG035xNOarHcA9cDoA+CYrViPBmZkhL/pVwJqjiSm5tHoE9w0H5L+55nKujyhh8ajYQJYa/XII
	DwaQ0ACP+dGYYkKGQpbmGR8qttKnCVlLts1Zk7z7Tah49SxnI29G9K8vNqa1pb662goPfKO3gszFP
	91k8fEzVFqNBPSk2thEHgSdNsYUutKccqGG+A19kprzjuiKwPWZ0R0tYit2V2KVGFt3WjQtlcIuXs
	q63NHQVbezSNV2osPwgpRD0ssmlN6xH/R6pH+ctI+frz6z8xmVzSmkXnRlLIcPgVCFPjUvk9jZItI
	uWd07CWfson5wOFXRQNg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1688042167; x=1688049367; bh=bT
	G+9AqapEnTzTdZN+3/z4mAZ7LW415XlukWbIMXEK4=; b=jVer3ZsYEpv4oKp9MB
	szsrrrdYGu7rGZrQTOVLMkGALoFHHLvc/oUUpXJBoXJgdCfT0l7aA0yKhATrYNXB
	aEGN9jvcC01pqiHdFsqq0bkFFSz9UIn0wpYtG5wYSyHBgIUb0q0WF10Dn3D0ys+Q
	XdVTz1xDdvBF5BWZT8QJkN/TJUgNTFQEn9uRiImRIIIxVlZAUYgfDYxAZN24C9If
	0fvLO/7Vh+JJJx9ib3bnVyk06XlQdUmqqoWItzk2IhpGynOSTiS1PFOrwsJCeCaJ
	8UiDOATEhC65kKFJEjC7rOkzppp5TX9XQuMvRoXskdiug/iaC/tnwPy1ygPdzaL6
	IoZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1688042167; x=1688049367; bh=bTG+9AqapEnTz
	TdZN+3/z4mAZ7LW415XlukWbIMXEK4=; b=CccPJWvx1a+Oz1MM5Taiu9fsGftW9
	hmgBcLqXYChcnfp2nv6RWUg7M5kQcytbmDfhV1AVipcw49+CmNKous2ER6JLcGud
	qLKDK3EFXotIhbICdzx3r91mhkebGgUqVWBxeOtOqIwIjt2VLx2+7M0e0ZNBw8IY
	QYBew9HSxFvupkHfoU1p8ZntBi5WUvQWBmTXQhafzKFZRTGtPdZIsRBX2guG6EvC
	jm91VDAmWV04RD50eKeuNQ1gIbDXgSNCl/ADV15oAHykwZ0L0pLZZYK3u1cr3+Rr
	x7zXD2MAiXbufbU1CsLjDKzyEFWnoX4+00s21o08yDXbrmZmwqDH+dXBg==
In-Reply-To: <20230629121952.10559-8-tzimmermann@suse.de>
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
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <pet>

On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:
> The global variable edid_info contains the firmware's EDID information
> as an extension to the regular screen_info on x86. Therefore move it to
> <asm/screen_info.h>.
>
> Add the Kconfig token ARCH_HAS_EDID_INFO to guard against access on
> architectures that don't provide edid_info. Select it on x86.

I'm not sure we need another symbol in addition to
CONFIG_FIRMWARE_EDID. Since all the code behind that
existing symbol is also x86 specific, would it be enough
to just add either 'depends on X86' or 'depends on X86 ||
COMPILE_TEST' there?

      Arnd
