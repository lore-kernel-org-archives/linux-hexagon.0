From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH v4 01/16] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Thu, 16 Feb 2023 15:51:50 +0100
Message-ID: <f93fdb4e-05e0-4301-95c9-3e1b1200d9b2@app.fastmail.com>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-2-bhe@redhat.com>
 <056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com>
 <Y+5B/PmGinjCk/fN@MiWiFi-R3L-srv>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676559129; x=1676645529; bh=NIjxx9AOK+
        F7JHTOG3oPUrVs9nZK8w72u3K+EL5dm5g=; b=Ket9xA39E8fhhUTFhkTIYG/3Ph
        OWvXEXCQQCRMHIt/UZV7JbM9ZqVgVa4MjDJb6JAZQ9pXgF7sV81tY5K5n9DhRsEJ
        pD//pZK9wLrQYVOaQt0ZDTMc4yr39ujLUG9tlNkbKxcjGzrShzzIBwE26LuF6eAi
        /YdqUEJtOiwIRe24BQA35A0IqFn5BmwDHziCyLE0Iq0DGdFV5YSf2ZngIfewzl3x
        diepT4Elgn2M+vFsDerQFwLpea2PXFc8WzD4vibI/dwxFiOvKR2YJmzN5Z6nwqYq
        teE/GTe7onUjWT/OuLsKkcfmdqIvUlfGcSWMV1N/YOPQKRlUqRgwcJR79BzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676559129; x=1676645529; bh=NIjxx9AOK+F7JHTOG3oPUrVs9nZK
        8w72u3K+EL5dm5g=; b=YBE0LyzAKrzRPMcDFCamvHwT8mGKAAG2C1CiSL3mDSA6
        DtxGoaVKO4UscN/zNE1duxDTyvEFyT5c9W9E+/P4vCzyfDrQZXNI/8rGmRXt3rLd
        nEa3moiqRRENkdA4N7GRzBhWHz1n+T4W+kx3T6SUWe96gFFq/YsLLpcZ+FZfmv/G
        FOAysoPiFuIQJ60cDNf12AayUPtE7qVsmbvsGprUfYrvvvU2OLhBbeIxPYwKobuT
        Fg/JA1LXkbj52QyDHNQz/RYl8OrpnpJM4l8CCW1fD+GM3kz/OMIdS3Z8JRwL8Zzy
        I0/SG7dd0Dk3I+HqK5R93NXTEmTzTEtvWeinObEUZQ==
In-Reply-To: <Y+5B/PmGinjCk/fN@MiWiFi-R3L-srv>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Christoph Hellwig <hch@infradead.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Niklas Schnelle <schnelle@linux.ibm.com>, David Laight <David.Laight@aculab.com>, Stafford Horne <shorne@gmail.com>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

On Thu, Feb 16, 2023, at 15:47, Baoquan He wrote:
> On 02/16/23 at 01:53pm, Arnd Bergmann wrote:
>> On Thu, Feb 16, 2023, at 13:34, Baoquan He wrote:
>> I see that there are only two callers of {devm_,}ioremap_uc() left in the
>> tree, so maybe we can even take that final step and remove it from
>> the interface. Maybe we can revisit [1] as part of this series.
>
> I see now. Christoph Hellwig ever mentioned in v2 reviewing, I
> didn't get why. Thanks for the details. 
> https://lore.kernel.org/all/YwHX98KBEnZw9t6e@infradead.org/T/#u
>
> I am not sure if it's OK to do the change in this patchset, maybe
> another patch?

Yes, a separate patch would be ideal. If you do the same change in
more than one architecture (other than ia64 and x86), you can combine
those into one patch.

    Arnd
