From: Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 6/7] qed: use __xchg if possible
Date: Mon, 27 Feb 2023 10:56:47 +0100
Message-ID: <Y/x+XzSaHTo23F/H@ashyti-mobl2.lan>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
 <20230118154450.73842-6-andrzej.hajda@intel.com>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677491817; x=1709027817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QoU6yA4OU0JwXW/AH29osWOnR5IWich2UMqOTYGbHiA=;
  b=GZ28Lyb4jnzXy21OhF0+LFG0v6lgrq79rE8SQXADVzlofWJ4RL8jOI0Z
   ZHqFj6a7a+LYZWOefhTEdXABpXiWFqrb84Ugad3wIfc/pHGzZry10K2q/
   FXTMk97YXesnYvSP6dRsLjzYQ0FuKTkKtQSmM+8nR01eF8YvimKethypR
   GzXanmasaD+uU+KRk4rFVQya1WlLJcELzotkmwgBPtIQaTUcEuDddrPfz
   HcG2YSlcDiXZJ0A+WgLemqB6dJ+xeHx+Uskr6K5FgLsoyQdLEPDVtVXuT
   HDYUGk6ic5JzypT0Jg2acUHlwe63D64nnfNlQaGdQqZIdUiXDcDoTSmk4
   w==;
Content-Disposition: inline
In-Reply-To: <20230118154450.73842-6-andrzej.hajda@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, And

Hi Andrzej,

On Wed, Jan 18, 2023 at 04:44:49PM +0100, Andrzej Hajda wrote:
> Recently introduced helper simplifies the code.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
