From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] profile: setup_profiling_timer() is moslty not
 implemented
Date: Mon, 25 Jul 2022 21:48:28 +0100
Message-ID: <a5b079bb-64ab-092d-27d4-d32d0d35afcb@codethink.co.uk>
References: <20220721195509.418205-1-ben-linux@fluff.org>
 <20220725123948.f16674b10022404814161d4a@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IF3im/aO6SeHdA8DwokfcCyyk/WtkWn3+JZLtcoeA3A=; b=t3+7nVqdJ/+R9A
	kF8z0mImNXQhccNRE3UmoTSwHDisYqHCrJj7o/3d+KmNpSIHPU6FO+qmbCqsgx6oM1joNmx6WQRbg
	t0DtAUHQcr6bACg9OV8+elkC8omJ389mU2ojN+jRYrCj0d+HVi6QMPBzdVcPO17B+9L3+btqwUo9/
	ossmWgKTx/yAkCRzkVytFVGrnXOt6Y4ngVoCl8KIl7dmlXroLFwrM25pfM7r2n5xeKM887P+ONoom
	rEZXa3OkTVvvyPgVyjtc4ntZX/3LFDAFFWqC+sv1/eAe/IgIpxh9nUwptdNDJaowJa1IYLVYo3dD3
	tPC61RhUqYhzqMo7YmCQ==;
Content-Language: en-GB
In-Reply-To: <20220725123948.f16674b10022404814161d4a@linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, openrisc@lists.librecores.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-alpha@vger.kernel.org

On 25/07/2022 20:39, Andrew Morton wrote:
> On Thu, 21 Jul 2022 20:55:09 +0100 Ben Dooks <ben-linux@fluff.org> wrote:
> 
>> The setup_profiling_timer() is mostly un-implemented by many
>> architectures. In many places it isn't guarded by CONFIG_PROFILE
>> which is needed for it to be used. Make it a weak symbol in
>> kernel/profile.c and remove the 'return -EINVAL' implementations
>> from the kenrel.
>>
>> There are a couple of architectures which do return 0 from
>> the setup_profiling_timer() function but they don't seem to
>> do anything else with it. To keep the /proc compatibility for
>> now, leave these for a future update or removal.
>>
>> On ARM, this fixes the following sparse warning:
>> arch/arm/kernel/smp.c:793:5: warning: symbol 'setup_profiling_timer' was not declared. Should it be static?
> 
> I'll grab this.
> 
> We have had some problems with weak functions lately.  See
> 
> https://lore.kernel.org/all/87ee0q7b92.fsf@email.froward.int.ebiederm.org/T/#u
> 
> Hopefully that was a rare corner case.

Great, thanks.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
