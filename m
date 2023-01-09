From: Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 6/8] treewide: Trace IPIs sent via smp_send_reschedule()
Date: Mon, 09 Jan 2023 19:01:22 +0000
Message-ID: <xhsmh5ydfedml.mognet@vschneid.remote.csb>
References: <20221202155817.2102944-1-vschneid@redhat.com>
 <20221202155817.2102944-7-vschneid@redhat.com>
 <CAAhV-H6Oii6t-4aHFjgPkCgFAd+LcVVg+7jMu_w4mEa0Ecuwaw@mail.gmail.com>
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
	List-Owner; bh=ZZIxfaJ7cpmwARX0iQIA9lom9paETn5l7LuiL0edNno=; b=hmqkAcVNdvK3Bk
	D2gtWtQd0/QgOgDDFTT0vscWMCKG/VzlLsSVPD2RITvZkW7DX9yp6nDFndbTQq6FudjlvBizA8WMR
	O5vrWPED8ffr/ZglAbozs7+rkPpkkF7jHLU8bhGL2EW+c5zax8/uVDdT5txxttq3qWvRTw51b6NE3
	YGx8FiDue5Zd4ViNdi/F3K6WzW6cLMkiMASLNkaQlxxVCJDeJ3nIj5FKNdFREd5GlyiTMNkb0a6gS
	wZhD8QN4DCfyK3hmKldveaTwStSHqeBLL4DC37NzcqsX4V2/7ISlnR2WEaEWveHpga5ZMJIJy+pyU
	JaNRm0Mhfzg0BapWsWCg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673290891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bU+svoPcyEEDaWYmIcNec69dTXz5hTgyu3b7xJNjXUQ=;
	b=TVfZqP1sM93wEmFIayUEh+PY8zjdK5irX+7Le2qgA33HbMFwjrGUUQGCXWLOg1U2MUVLVy
	UhkGJs9dO/PZ9yYILR48seBj+Q2Wn3OpT25rg9C7Gpr6Q+qHGJ1xnpvy3BGqFEw1douyWH
	5INe1UFybdOG59vITwt+fVv9jwDDPqc=
In-Reply-To: <CAAhV-H6Oii6t-4aHFjgPkCgFAd+LcVVg+7jMu_w4mEa0Ecuwaw@mail.gmail.com>
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
To: Huacai Chen <chenhuacai@kernel.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, Guo Ren <guoren@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat>

On 08/01/23 20:17, Huacai Chen wrote:
> Hi, Valentin,
>
> On Fri, Dec 2, 2022 at 11:59 PM Valentin Schneider <vschneid@redhat.com> wrote:
>> @@ -83,7 +83,7 @@ extern void show_ipi_list(struct seq_file *p, int prec);
>>   * it goes straight through and wastes no time serializing
>>   * anything. Worst case is that we lose a reschedule ...
>>   */
>> -static inline void smp_send_reschedule(int cpu)
>> +static inline void arch_smp_send_reschedule(int cpu)
>>  {
>>         loongson_send_ipi_single(cpu, SMP_RESCHEDULE);
>>  }
> This function has been moved to arch/loongarch/kernel/smp.c since 6.2.
>

Thanks! I'll make sure to rerun the coccinelle script for the next version.
