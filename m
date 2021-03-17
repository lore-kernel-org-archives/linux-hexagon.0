From: Anatoly Pugachev <matorola@gmail.com>
Subject: Re: [PATCH v2] mm: Move mem_init_print_info() into mm_init()
Date: Wed, 17 Mar 2021 17:03:22 +0300
Message-ID: <CADxRZqwFokuZrhA6GFr=whM3s7BqZpzo8yq=TW6YEr=eeEUH0A@mail.gmail.com>
References: <4d488195-7281-9238-b30d-9f89a6100fb9@csgroup.eu>
 <20210317015210.33641-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6OaFjyFWgg4m3b9LuLpqb/rP6tn5J4G93CnXJEjgfLQ=;
 b=i2DpCpQM7JeSSiS/pjMxgtMmRWaqyEUnqOkpir3k6hjfU9Oor7nDorySG4w47CoCGd
 HaiLgTyqU0kC8zA/M2kZQM1sH1E1LbWud/WbA8om7HWvSV+BUakqiOwPUeTLcoqCLPGf
 JedwFXQpUMM2xc1N014Ahaw2YTMoAf2cj3FsgDsCKv3ZOzvpAcW8c+eMj3EENF375f8x
 11rayPkdrSyY5YcS7+D3f2mNmy0iI8qzZ8PRIa+NRFehp669D1SyF0qYVVKeD+gzVYK8
 LIsktzMZcnA20N+P0QIhTw/wSHTpN81axxWdN3YKq6VrI5qwWqPf0cj92aOsspj4iCYa
 aQLA==
In-Reply-To: <20210317015210.33641-1-wangkefeng.wang@huawei.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org, linux-mm@kvack.org, Guo Ren <guoren@kernel.org>, Sparc kernel list <sparclinux@vger.kernel.org>, linux-riscv@lists.infradead.org, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, l

On Wed, Mar 17, 2021 at 4:51 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> mem_init_print_info() is called in mem_init() on each architecture,
> and pass NULL argument, so using void argument and move it into mm_init().
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2:
> - Cleanup 'str' line suggested by Christophe and ACK

applied patch (5.12.0-rc3-00020-g1df27313f50a-dirty) over linus.git
and tested boot on a sparc64 virtual machine (ldom) - boots.
