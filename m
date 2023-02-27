From: Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 5/7] io_uring: use __xchg if possible
Date: Mon, 27 Feb 2023 10:59:04 +0100
Message-ID: <Y/x+6KutaJKGv+Zz@ashyti-mobl2.lan>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
 <20230118154450.73842-5-andrzej.hajda@intel.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677491956; x=1709027956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jR91B98qom+5gzYhQGkhIgN06B7vIdWxDnI3INGZGCs=;
  b=BsxIg7k0v3M1jV4470HDihWCqyLv1+MNESts87+xvkfr5e2cRoeHJCwe
   MRNQ2I8pB/1FTBFfhDUgcJEhsEkz/zrJKMmuDl/IgSxoq+GdftovZmJz5
   n8ZJ+L17wsawWJ0mTcKyMo9uLN4H0PkByBsTGCJL8feKkxYQFAVprxndW
   i4l3l759AA6UAPnOR99Q2S1Z4+/tTTDf3pdcrA1QXA26ORvF9LqTL0kuY
   SEowQ41opWvZ0vgamVTMUFLDTeomyRdeIqlKvYXrMBzCHENl9M11SiyOI
   LL3gnISY3ohq4bt4NZHeaMZgzTLXNYTxqKEzk7GIkSVH6Mp+A0OYMo3VN
   Q==;
Content-Disposition: inline
In-Reply-To: <20230118154450.73842-5-andrzej.hajda@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, And

Hi Andrzej,

On Wed, Jan 18, 2023 at 04:44:48PM +0100, Andrzej Hajda wrote:
> Recently introduced helper simplifies the code.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
