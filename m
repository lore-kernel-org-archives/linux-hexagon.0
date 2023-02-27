From: Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH v5 4/7] llist: simplify __llist_del_all
Date: Mon, 27 Feb 2023 10:55:37 +0100
Message-ID: <Y/x+GTZzRJ7ExEPd@ashyti-mobl2.lan>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
 <20230118154450.73842-4-andrzej.hajda@intel.com>
Mime-Version: 1.0
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1677491747; x=1709027747;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2+o9dIFNlD8/pbPtj1kqozcC4rPUj0z7l8HRWh7LVuA=;
 b=OZR5Cx/MpYorAfshY3Dcc4pK2Dp7TWB8v/SotNnLyljLGajEu9kc3ZIy
 hv4Shl9ShpkCCNnV4Izke1DwEbjvZt7Pj4WK9Ap6YeDB7wWucWDDpWjS/
 rr9/z/RYWX3UDd5aau767E3Xt/iYfUjQuvKKb4JYTK1quhtCCdPQ2NY41
 ROEBbCdXF2d799ZPx/tBrKiKR+Sbml6y4Bn+sKU1ySoQPsh7NO4tQ1fhm
 gfIsdYzQRQgGeXz91erGQ86Yg4HMhIBMztQRA1ruqjpPq/D23/PsZcK06
 0PGhxuiYScKg1bDzYsrdXXXueWNTgZRrNFWZKwG77K0jwJsOHZHW8SgrL g==;
Content-Disposition: inline
In-Reply-To: <20230118154450.73842-4-andrzej.hajda@intel.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org, Boqun Feng <boqun.feng@gmail.com>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, loongarch@lists.linux.dev, Rodrigo Vivi <rodrigo.vivi@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

Hi Andrzej,

On Wed, Jan 18, 2023 at 04:44:47PM +0100, Andrzej Hajda wrote:
> llist_del_all uses xchg, let's use __xchg here.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
