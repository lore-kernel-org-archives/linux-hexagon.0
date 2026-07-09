Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC82853E9
	for <linux-hexagon@vger.kernel.org>; Thu,  9 Jul 2026 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586970; cv=none; b=Rx+gPf70l1x+tgNKPTsvNyiYIkzKcM+UmUBIdZTixp4+QTxGH6FEFr1YkyZqVsh4NNeEAoQQ8ju9blvzVx1xoxkA3YtD66JpYTKRXF/qAbaAVza3w+re9iaXEIMY8ccsJQFFD8RaCkRCJKrKbHzq/aPmn8WP3odm3fPsqKswGwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586970; c=relaxed/simple;
	bh=vcIYcFn8wOu64JToHCd3V3ghUBsco6aWxPDuriYHfZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFvOltWztS6MmGWz6PaessYyBQeeDTWMN7MK8ifav2YIijbxiKcgkaIDT5TDdTKodigntSsqOo/nmcF1JHw5Tq6EeFkGKx6quSFq8XWCrImI6ubn05P4irmFFfsJ8zOAIRL3I/khMO7cGvW419UJCRQMEkybIzJEfIYPt143ZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8478fe07f65so1593998b3a.0
        for <linux-hexagon@vger.kernel.org>; Thu, 09 Jul 2026 01:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586964; x=1784191764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O3mkBNkViagFAJs3obyg41kBlrTMtmvpPUP/R2gZOPo=;
        b=MEm2wtPIaXGMDKUTCG5tJf9/BZY9TNUPuccQoQEXp0sXtsDs7TyzK8geTSvc3vcdur
         lpXeH6cNEV7UvrzuvNsfM2Mlrht93zRaswU5Uqit8oOrgYGvuY8ViQYwhaZjvjA4QaWY
         DrnN+ybtl0hXeubEU0rPkq8QzwZumkaXJe8yD2Zghu5RvXwYdXPIVtU7vPHTr5GPVuLv
         2yN7IvMCoy5sGJ7cp3dLkeGCLW+8MellauH7QSRxY30ePcFlMnpYMdr0KnEGRjZF3Csn
         i6kTDzw46WQuKT/cgYIV6ljkt7i2VRcCB7oDiLfzWj05h3mbHVo8LEcLm5D//u294j/A
         QqQA==
X-Forwarded-Encrypted: i=1; AHgh+RoBfNLy2c8YRamr+gJhXbayX2ICataO3YGnli8P7KlUGGPH20wG2eoYRJIkx0bRGdafsUucDKSN3jO96WUh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ctU8ccYCM6ydZcNVj9sZfTCv5CYkCy6/4CfzNzaaNUzBoKQw
	2ebMqarqW4m56F84MfEKEcZ44Q6yyCbRYOrZFT6JtTK1LDLyHLbFEwUx//gn12xY2/0=
X-Gm-Gg: AfdE7cmEfQYqMgD8pGpw6trvioxll0437feef3MC6IJYgNheGo5PXwQAw6QGwnck8Wj
	H5dY4RbIsvfKiolxkynJ1Ji5k8hsPmELWF6PzVzh0nSRYlkOdVsUDSbBrxbMaqewHTYgttLY601
	kq0pqTkmSC0TVrCWVUJHgJ3g5KFr207DjuxNMC3TJtLjq4Qwyp2O7WE7rzadL7Tl5nBtrgrfwKp
	yWlNijd8Rzpn119vFppwrWckRgyfM1PlLIPxHqYJ+hfP0AV22xBrs3VQz2QugRRQ22Osc70LQVm
	B+Ofd8IEgOwR99AtIahifPftZcg/X14xcYvq14/o8gzN19T3Uqnkl87QW0G2CCoD4dIhbREAr0M
	lzWAGuSNSKbAtyxyl2IpuNjXj8LW/H7bLZCTZ13XPVi/X57Hq3vykwMnXONcG6sYH8O8wX8ktsL
	6aUPw0/uWGEbOXue4iIdCL5Stvo90h2mi/VbhcV5LHAxwzklHFuplZyQXf09vZTcBP
X-Received: by 2002:aa7:88d5:0:b0:847:968d:b101 with SMTP id d2e1a72fcca58-8484301d1e8mr6189438b3a.21.1783586963804;
        Thu, 09 Jul 2026 01:49:23 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848593a591asm739692b3a.26.2026.07.09.01.49.23
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:49:23 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso944781a12.1
        for <linux-hexagon@vger.kernel.org>; Thu, 09 Jul 2026 01:49:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrkiMlGoCzfB2EeQYIdVOt0hsXcO5qZ0XcYCMfWT2S0tliLooMHFQnYxRM0Sq03amfSFWcatdKjOXWlD9h3@vger.kernel.org
X-Received: by 2002:a05:6102:6895:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-744e03a337dmr3306957137.20.1783586528282; Thu, 09 Jul 2026
 01:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <20260707190254.280015701@kernel.org>
In-Reply-To: <20260707190254.280015701@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:41:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
X-Gm-Features: AUfX_mw8w2Kp5VuAYozzfDNS6gDbdKhQdYzfXsv-G72F3LS58UBytbGwOmplITc
Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
Subject: Re: [patch 12/18] ptrace, treewide: Rename ptrace_report_syscall_entry()
 to ptrace_report_syscall_permit_entry()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 21:06, Thomas Gleixner <tglx@kernel.org> wrote:
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
>
> Rename the function so the purpose is clear and make the return type bool.

>  arch/m68k/kernel/ptrace.c       |    2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
