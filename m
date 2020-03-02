From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] mm/special: Create generic fallbacks for pte_special()
 and pte_mkspecial()
Date: Mon, 2 Mar 2020 12:19:28 +0100
Message-ID: <c026934a-02c1-8589-f925-e267fcc367ad@gmx.de>
References: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EWWuvoQPT834Udf1O0YbmPQqp6hbQSV17ozHK/JzOJw=; b=LyglAdnXoJZKNg
	cs9wC4sKGS9zzi9pjRw1bxmH65iVqIzGZNdh9GeK49phZBuk4odz/pBnwmsjoeaW0S3q1MvENMBV7
	qz7DCq0fS/Fd3Y/9HlE+umAyH5W9D/bj9Irvae5QURZHnuUow0/Eo/uaxH3Kh6GAIJODBxGrobQZ/
	f4DRuXYpBweIBEnIThgf1dcG4N/xF9xju2ANWXF0PnUMQU13UjJbxcW6HeIPu0JT0XUTEGJWnggA7
	TJVZBHWTD0gZMWZ5Pd/YJ55E5dw7/SxYgY+Kcof48PFtXzneUC8wsMHQqBW3Xz+UXvIF9wxqEJcbs
	j0GBfAq5TQNrV/7D7LWA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1583147984;
 bh=W0AEuRxwaNTM1wIbdflqt1mDaAQNU2XGAUPwGpFwfWw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=hTNTiGkPrHFpfzTv92CxoDj+m/u7w8wulahh2YNUZ3ilgCKTOf7jYgAY8yD9Ao4qv
 SytwzZHwpUWQzFzBhJtl2DIhQoCUV/ToAeRl5zIDJgbyNck2JHuucSsXxomLmXYLp/
 +Dei76MRo/TXrQDxaEk4FvqRCIn9xEsmVcXYatHg=
In-Reply-To: <1583114190-7678-1-git-send-email-anshuman.khandual@arm.com>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jonas Bonn <jonas@southpole.se>, Paul Burton <paulburton@kernel.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org, Matt Turner <mattst88@gmail.com>, Sam Creasey <sammy@sammy.net>, Fenghua Yu <fenghua.yu@intel.com>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-m68k@lists.linux

On 02.03.20 02:56, Anshuman Khandual wrote:
> Currently there are many platforms that dont enable HAVE_ARCH_PTE_SPECIAL
> but required to define quite similar fallback stubs for special page table
> entry helpers such as pte_special() and pte_mkspecial(), as they get build
> in generic MM without a config check. This creates two generic fallback
> stub definitions for these helpers, eliminating much code duplication.
>
> mips platform has a special case where pte_special() and pte_mkspecial()
> visibility is wider than what HAVE_ARCH_PTE_SPECIAL enablement requires.
> This restricts those symbol visibility in order to avoid redefinitions
> which is now exposed through this new generic stubs and subsequent build
> failure. arm platform set_pte_at() definition needs to be moved into a C
> file just to prevent a build failure.
>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

for parisc:

Acked-by: Helge Deller <deller@gmx.de> # parisc

Helge
