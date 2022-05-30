From: Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Mon, 30 May 2022 11:35:10 +0200
Message-ID: <33fd4731-9765-d78b-bdc3-f8243c98e81f@linux.ibm.com>
References: <20220527193936.30678-1-peterx@redhat.com>
 <YpPYkzbrQmy4FjrI@osiris>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ng6QDHiym8ko3LZgo1Eo2j/En/Lp09aJGcAb2nd2wNc=; b=DoHbX1AKv3PzHh
	Z5IwooVtDypB4z9tSLcmmT9e7v7ut4WUCs2F39jmqZXwwVlAJ9xnoFu0T3Tcr2IsF9d2zxFeejBZU
	bmxvA+lkuFiYZF2+VhGrf+JnKGcfefFWaT8lX1vc5mdqzSQwUagEDfWozmqGN+tJ5Ob+IBIP4xdNi
	ou78zxkR6+edVvy0H/VgC1iuGd5t7ZTaQdJYwkzjVDLOvaBNza+Qd+sWLvsFA5sHs3ADlUfuCloT1
	tZCeAFzhHjC8n/atfVq+LPiGkqEgw83NvVbTOOqCg6WQpgryDITKX0U+Cuwmbrgqn6RMOVPW7VIdX
	MSpQyboIV4DnA22f0sfA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZYzW3+GXOL8I0AfUdLsg5MVY8XGCNIfi5dgvNuU6uaU=;
 b=aJRxENPLxPxtJPLPMpZbZB6ZMNv3yb0g75x/iaJw7LwXznLfzcFFd+VhsSYa4DDin1Og
 h3EtEuduOMNJdyWcPGf8Bp6j8HIvSzuOxy/3v6U/k2EZA3ai81b28DfbzQAvyLegWbh1
 6JeeHGepvOgSmc7L30MoUcRt75rv2HhxbCLI6q4veiPA68Sc+ilz6QI6uDVuislGDiwl
 YeuRHaNHYRJKefnUIzx1TjXR7BhIi0QNPJjTPVc/RjJeQKBVl5otsnG/aMJgufq14x+Q
 SfzDBggiNkH6uIogm1bEat+ek9Ln35Wju1AiyyoOtoSpZv9Lk89aLEZ/3hCHMI9fbtzG Eg== 
Content-Language: en-US
In-Reply-To: <YpPYkzbrQmy4FjrI@osiris>
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
To: Heiko Carstens <hca@linux.ibm.com>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Will Deacon <will@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@quicinc.com>, Borislav Petkov <bp@alien8.de>, linux-alpha@vger.kernel.org, Alistair Popple <apopple@nvidia.com>, Jonas Bonn <jonas@southpole.se>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, Russell King <linux@armlinux.org.uk>



Am 29.05.22 um 22:33 schrieb Heiko Carstens:
[...]
> 
> Guess the patch below on top of your patch is what we want.
> Just for clarification: if gmap is not NULL then the process is a kvm
> process. So, depending on the workload, this optimization makes sense.
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 4608cc962ecf..e1d40ca341b7 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -436,12 +436,11 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>   
>   	/* The fault is fully completed (including releasing mmap lock) */
>   	if (fault & VM_FAULT_COMPLETED) {
> -		/*
> -		 * Gmap will need the mmap lock again, so retake it.  TODO:
> -		 * only conditionally take the lock when CONFIG_PGSTE set.
> -		 */
> -		mmap_read_lock(mm);
> -		goto out_gmap;
> +		if (gmap) {
> +			mmap_read_lock(mm);
> +			goto out_gmap;
> +		}
> +		goto out;

Yes, that makes sense. With that

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
