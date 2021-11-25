From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 01/20] Hexagon HVX (target/hexagon) README
Date: Thu, 25 Nov 2021 00:26:58 -0600
Message-ID: <ee0ee7c5-22e5-2c79-695d-e66ae39bb5fb@landley.net>
References: <1625528074-19440-1-git-send-email-tsimpson@quicinc.com>
 <1625528074-19440-2-git-send-email-tsimpson@quicinc.com>
 <1b632e88-43d4-3034-cf7b-d42be056d842@landley.net>
 <SN6PR02MB42054B50C60ABA378256492DB8159@SN6PR02MB4205.namprd02.prod.outlook.com>
 <553c32e8-188c-5b2c-2f4a-a8cfd7b903a9@landley.net>
 <BN7PR02MB4194007550E66EBE877625A6B8E19@BN7PR02MB4194.namprd02.prod.outlook.com>
 <BYAPR02MB55091DE5B976956075B46FADBEE19@BYAPR02MB5509.namprd02.prod.outlook.com>
 <8845de00-ddc7-86a3-600f-6ede81e168c2@landley.net>
 <8192e9bb-a0de-1b2a-271c-ac7323be8244@landley.net>
 <BYAPR02MB48863186EDD71439C60792A0DEE89@BYAPR02MB4886.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane-mx.org@nongnu.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/ZqZmF+q1iwRbg9wNdhq1jqh+3PguSzbZtWn7yBzt60=;
 b=VXJK1TU4jtMYNycpca5aWKzvU2ukuz5F3VcffWGQ35/7f5+0a5nkSfmje3P5MmNNEh
 Nk1NVVjwGiXgvwlILu4bS1RdSTlwvfUCho51xcj5F7NATF1zXfminVNZVln4nVrlDs7P
 MUMjgTdSUmhvorKebKb5NeZO3Yic2TdikmqGtQ30C/jKg1mbAd41pTbJgEIdLLxeLc+/
 q9dcj67TjFjA7DVwJLcBAK226K07md0+lMmDnKmsJLNTfRu7zGptcMHukdZ4yqcvvcOz
 LthwSHLoLRB7GZCwDqpzfGgzlbVWO83k4/tModrYJzr9eQ5qCwWYJDxZWxmiC9EkxvWz
 QfsA==
In-Reply-To: <BYAPR02MB48863186EDD71439C60792A0DEE89@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane-mx.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+gceq-qemu-devel2=m.gmane-mx.org@nongnu.org>
Content-Type: text/plain; charset="us-ascii"
To: Taylor Simpson <tsimpson@quicinc.com>, Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@quicinc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Cc: "ale@rev.ng" <ale@rev.ng>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "philmd@redhat.com" <philmd@redhat.com>

On 7/26/21 8:59 AM, Taylor Simpson wrote:
> We're working on system mode support for Hexagon, and we plan to upstream it when it is ready.
> 
> Thanks,
> Taylor

Any progress on this? (Is there a way for outsiders to track the status?)

Thanks,

Rob

