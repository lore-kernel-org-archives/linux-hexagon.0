From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH 1/2] arch: hexagon: include: asm: add prefix "vm_" for
 all enum members in "hexagon_vm.h"
Date: Tue, 26 Nov 2013 12:36:46 +0800
Message-ID: <5294255E.7040105@gmail.com>
References: <528AEFB7.4060301@gmail.com> <20131125011938.GB18921@codeaurora.org> <5292B845.3010404@gmail.com> <5292B8A0.7020409@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Nfic++6f6QBbvoSDKDw+MVCfYvY8S8YRKjYJ+yb4nDU=;
        b=HQypKsVeZBOy1/k4af36PEpFlpV90v9lpFlnAqgj2om6oARbBulIi/Yg90NSkSkOgz
         V7DUjrCp2Dl+7MGZlvb+x2odalEarWioraYuLkTi159nJCC3S6eJpbsuODSprt1xnZ3g
         Shs7EOGaD15ecMaHFr/JGhnTa0fN0PF67bqb+j30ZYcUeDOa1JdiEQ+mc8zRjRvpIqdH
         1aG6/suEx7LgZdFDfEaqmmsP6PBlNsQScxwBGefY8KlLYoZjpXRzE2p0VfydqjwVmCb8
         m6U1EA8OEEbSoMa1R34DZl1CYXy87CI9jZVw6i2WD/lIXhX0YM/Z6Zvf3hVZGgJ5wqrD
         iTCg==
In-Reply-To: <5292B8A0.7020409@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 11/25/2013 10:40 AM, Chen Gang wrote:
> Append "vm_" to all enum members (which are too common to make conflict
> with another sub-systems). The related error with allmodconfig:
> 
>     CC [M]  drivers/md/raid1.o
>   drivers/md/raid1.c:1440:13: error: 'status' redeclared as different kind of symbol
>   arch/hexagon/include/asm/hexagon_vm.h:76:2: note: previous definition of 'status' was here
> 

Oh, sorry, The new prefix "vm_" is still conflict with others. One case
is below (bottom of this mail)

I will use "hvmc_" for VM_CACHE_OPS and "hvmi_" for VM_INT_OPS instead
of. If get no rejections within 1 day, I will send patch v2 for it.

And also I will merge the related 2 patches together (although they are
for 2 issues).

> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/hexagon/include/asm/hexagon_vm.h |   70 ++++++++++++++++----------------
>  1 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include/asm/hexagon_vm.h
> index 67bb6d6..e1e0470 100644
> --- a/arch/hexagon/include/asm/hexagon_vm.h
> +++ b/arch/hexagon/include/asm/hexagon_vm.h
> @@ -55,27 +55,27 @@
>  #ifndef __ASSEMBLY__
>  
>  enum VM_CACHE_OPS {
> -	ickill,
> -	dckill,
> -	l2kill,
> -	dccleaninva,
> -	icinva,
> -	idsync,
> -	fetch_cfg
> +	vm_ickill,
> +	vm_dckill,
> +	vm_l2kill,
> +	vm_dccleaninva,
> +	vm_icinva,
> +	vm_idsync,
> +	vm_fetch_cfg
>  };
>  
>  enum VM_INT_OPS {
> -	nop,
> -	globen,
> -	globdis,
> -	locen,
> -	locdis,
> -	affinity,
> -	get,
> -	peek,
> -	status,
> -	post,
> -	clear
> +	vm_nop,
> +	vm_globen,
> +	vm_globdis,
> +	vm_locen,
> +	vm_locdis,
> +	vm_affinity,
> +	vm_get,

The new prefix "vm_" for "get" is still conflict with others:

    CC [M]  drivers/virtio/virtio_mmio.o
  drivers/virtio/virtio_mmio.c:170:13: error: 'vm_get' redeclared as different kind of symbol
  arch/hexagon/include/asm/hexagon_vm.h:74:2: note: previous definition of 'vm_get' was here


Thanks.
-- 
Chen Gang
