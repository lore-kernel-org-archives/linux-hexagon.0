From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] hexagon: modify ffs() and fls() to return int
Date: Mon, 23 Jul 2018 16:27:47 -0700
Message-ID: <39ac5a3f-b5fa-a928-6caf-a7a01251f5ea@infradead.org>
References: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
 <20180723225025.GC12771@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o11kUjuzMQNvGr3/6w+Q3pgFOCw7hRVK57TxVUWCmx4=; b=X0tYw9h5miidYDju2YrkIKYVtJ
        6p9sCf7is5oTZqdo2nBblVpVpbaGz9IFF09SvwQJt+A8ZgtmEwA4vP17HeK/W06eqMm5AJm78hzYH
        faAwLMI+T8653YlCi+oaFDsfkhv0CT2RDEuiUKInE6UUCEKuTVaxaCmZwYvsHnWA/nzHTjmU5uUjJ
        Rr0EO8oCPeiRMoIp8KcK2w4P3pD28Q6Uc6SZ1c8M/Kj7k9r47iLAKvAExPJCQCNRXyQJ4350vAOZt
        W4XXRDfcTAbu1Ct2rqh+jljAjX+46YO0I4wmMZLNny3ANxr+s3eXTYlBgIPq+ssUz2dghD/OgtoMx
      
In-Reply-To: <20180723225025.GC12771@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

On 07/23/2018 03:50 PM, Richard Kuo wrote:
> On Sun, Jul 22, 2018 at 04:03:58PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
>> printk format build warning.  This is due to hexagon's ffs() being
>> coded as returning long instead of int.
>>
>> Fix the printk format warning by changing all of hexagon's ffs() and
>> fls() functions to return int instead of long.  The variables that
>> they return are already int instead of long.  This return type
>> matches the return type in <asm-generic/bitops/>.
>>
>> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
>> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
>>
>> There are no ffs() or fls() allmodconfig build errors after making this
>> change.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Richard Kuo <rkuo@codeaurora.org>
>> Cc: linux-hexagon@vger.kernel.org
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> v2:
>> add hexagon contacts, drop erroneous sh contacts; [thanks, Geert]
>> only change return type for ffs() and fls() [thanks, Geert]
>>   [drop the changes for ffz(), __ffs(), and __fls()]
>>
>>  arch/hexagon/include/asm/bitops.h |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
> 
> 
> Acked-by: Richard Kuo <rkuo@codeaurora.org>
> 

Hi Richard,

You are listed as the arch/hexagon/ maintainer.  Can you please merge these
patches?

thanks,
-- 
~Randy
