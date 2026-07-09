Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322AB3A6B9D
	for <linux-hexagon@vger.kernel.org>; Thu,  9 Jul 2026 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621970; cv=none; b=BYc1A5Gj+1kHWzNVdjPRB0PJyVL/Nl8zzoeOad/5Awzz8UFvxoFX8p4BCfgiKkrbWLfmn9FG7G/YXhCGG0kwT7ugXidmC1egZEJ5w8tZEOznT8cxjD538Nqe656nmEDZVDG2wMajXJLIbSZD1uTpjJ7s5aCG2rUIbOPK0hE27sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621970; c=relaxed/simple;
	bh=CuadLq4gnh6A+s/YbTQsNOibHt22WuOTEhntcyj5qbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1jLBRlDdgH8nyGbQjBML07ELnkFKlMRbwZ0L3SpjUfg1Uv1mqt2DYm9H6SeGOApE8xZNGj7pLDQeSzN+f/zTnXORgmxYLUHXmq6VgCv9yzw/riM6R4iTFRNfOoMsSbsHg2CkhAnzuT3LDjGWIh7Meq8E8qUT/FKkRSDbjHWXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWkpnfjV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWkpnfjV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cad4170e8eso682275ad.3
        for <linux-hexagon@vger.kernel.org>; Thu, 09 Jul 2026 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621967; x=1784226767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M/JWBZ9pJgvX+aNnWpGPI681HI0WIvMMNN0M2xj5UX4=;
        b=KWkpnfjVTlyooxWnZivEMv29Lc4Rx9cDyF6J4LOxWofw2SYGiJ94402vXOQ3L+AEyX
         OnHDDP8J9Km6O1Ukmg3JVJARFTtv5Vxn8ULRTTXToivtQVQDPK5shmO1WDcLAh59C2OK
         F2Ny+Uj3ulcIuBV5OCgRwwra/fPpL9rhXVKUjB8BACaokK+QN/ogvVtY6kvcNBm9ot3w
         8GKcwjakfAAIawsqSPIGtmErK29jdSKpm3MEi1SXtRLJ8qaw4JiupfmgggB0TOs7i8QJ
         U4iRx6lyMoDPncNyF79obx9o/iFypE6ksXFgAbBOaoWpQYxJkULwJUNmAUBfXVhOssdN
         YcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621967; x=1784226767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/JWBZ9pJgvX+aNnWpGPI681HI0WIvMMNN0M2xj5UX4=;
        b=n+DdoyUjYUfKUVdsrNiFktnSnpCPOAar45mVyE0S83Vem3uxG9h67P6FRe72BsGUCm
         YCIpJqYFkPQbpaU6WaEEMqXPqcoPC6rU2ZRDUN2iQE8QoVMddgLJ9TzQatPzMqIVTdeP
         EDUDZwb2ZBg7UYxi182gNUqEGuWuT5QIDV99yOSH+irFNVggADIOGmWxx39gbbSHKwBL
         ad7YiodMr3GC4LPITzg2At/K+khryqASswfd3qLl/adglVVHLclX6KPojUfwLwqAp8ci
         InBOTyeCrCxNSSZX5bQNqxyYXZHCIy07UYwZa62euONjHoJwtY1TULgJPCvEtlW5rbJM
         fN+w==
X-Forwarded-Encrypted: i=1; AHgh+RpedlENgQ0swasd0FUVxpCBMfUnScdFeFy/E0WWMZRk0PkiUslCnX7eDm0E8R2Eu7mIFYJsblJ7Rq0Br4by@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw915GqOxaUlBMWgbzDc6uQzu9IcqYE4xhtKRZEh6yPpW80ORH
	YGd4tFZIQMg/VYzFAcsuXlMgmT18B69zD6Py4XFReNnQE21hd/g/hCym
X-Gm-Gg: AfdE7cmpqRqoxOnkKPrxhx3vuxTiik6ko4PAmz768pRJngN/bDqQjJqb6iXqCUY8S5a
	JmRE6hSoY3hASDANsjjJsAF+O8mRXgQR1hnGUkca52w8ZL5vLUBHd5WhYmp5HBFyswthND5GVnq
	hmLuE0asuFA5Xz5EW4VzZsX3wpMEg51ZeO6rhv/BpSui+zRC0bOJdjdSGp7+uE4q23SjlrWzcxR
	dMWWv/9FUshVpFWLLevVQBTbSNwF+gL30dvnwsufUKxCsmaDGazRMQ/rqu+9YlknHcBF3llClnq
	c0lAfZzbrHZz4DAgTJnSDCO22NqpaNfm/hp7j9N6TVdXPmXHEsUX7FHpuAIejgxWgVZ7asEmB2N
	Oc9f8ts85aAx0TwePeQbghPcFMuBCz9aI6TZ0gQ1WuG+inQ6QPciAteqE5zhuRmMTrcIszjFeJi
	CH1TR+sFXXVCNh1aGbERAinNwYnk4so3ejDcV8eLZx0Q7o22hqS4RMrZhvxnutU0BKRY9dwqY=
X-Received: by 2002:a05:6a21:3295:b0:3c0:9c18:d5a7 with SMTP id adf61e73a8af0-3c0bd1c4948mr10580989637.68.1783621966489;
        Thu, 09 Jul 2026 11:32:46 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm55669365c88.14.2026.07.09.11.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:32:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:02:27 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
Message-ID: <ak_pE64J_xnLQBMd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.718191130@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.718191130@kernel.org>

On Tue, Jul 07, 2026 at 09:05:58PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
> establishes state. That's wrong because add_random_kstack_offset() calls
> into instrumentable code.
> 
> Move it after syscall_enter_from_user_mode() to ensure that state is
> correctly established.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org

Thanks for fixing this.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

[...]
