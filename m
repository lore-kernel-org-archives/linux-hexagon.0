From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v3] arch: hexagon: kernel: hexagon_ksyms.c: export related
 symbols which various modules need
Date: Sat, 07 Dec 2013 17:35:17 +0800
Message-ID: <52A2EBD5.1010707@gmail.com>
References: <529811AE.8050502@gmail.com> <20131203011222.GA23175@codeaurora.org> <529DCE06.3040508@gmail.com> <20131206182502.GF11490@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eE2C2BKt7IUbvH1CbHExrnjK+BucRESMqf6nPZWyjWY=;
        b=W1H4l5yPP9T37BpEmsVTXh8e4Xa8tYlMtCsg+qkIT+d7XVLGt1u4zRCXtVF2+dMA2Z
         Ep1PXZs/CW9qH63hCSMmdH6atv6ge5gTVBrQk2t/3jtEDYEySts6yLAyhT43W+mnfmcB
         S9sbvRu3r+O28ZmYn65BI9PiSvIQ7tHBmiJvfn2JhAMCJRzXvyb53Yi4m18HPKhFmV+1
         RM85kn1p52+olZ7uvs9lAyirEV0A056l/BO9YbAYqtdIaAdOAnE7a8uu7vQ3EE+LrXbV
         ///eO7hC99niJMUv5ML0khe12tUxZ7xUsAyuTkcWx2ze4c/u/RJQYlVhk/y1aLiy6X83
         Q0UQ==
In-Reply-To: <20131206182502.GF11490@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12/07/2013 02:25 AM, rkuo wrote:
> On Tue, Dec 03, 2013 at 08:26:46PM +0800, Chen Gang wrote:
>> Need export all related functions and symbols for various modules with
>> allmodconfig. The related errors:
>>
>>     MODPOST 2879 modules
>>   ERROR: "__vmyield" [sound/sound_firmware.ko] undefined!
>>   ERROR: "__phys_offset" [sound/drivers/snd-dummy.ko] undefined!
>>   ERROR: "ioremap_nocache" [drivers/char/ipmi/ipmi_si.ko] undefined!
>>   ERROR: "__iounmap" [drivers/char/ipmi/ipmi_si.ko] undefined!
>>   ...
>>
>> For including files, need "linux/*" first, then "asm/*". All related
>> included files and symbols need be sorted by alphabetical order.
>>
>>
>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>> ---
>>  arch/hexagon/kernel/hexagon_ksyms.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
> 
> OK, hopefully I didn't leave anything out, but I'll try to upstream the
> patches with my tree hopefully in the next window.  Thanks!
> 

Thank you very much !


> Acked-by: Richard Kuo <rkuo@codeaurora.org>
> 

Thanks.
-- 
Chen Gang

Open, share, and attitude like air, water and life which God blessed
