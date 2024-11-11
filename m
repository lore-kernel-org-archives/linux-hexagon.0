Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2123.outbound.protection.outlook.com [40.107.239.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C97156678;
	Mon, 11 Nov 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335129; cv=fail; b=nqfYSG+grPfP4vRtvR9VDxjSfs3jflSoZ13fwffZRJZyW5xpxlk6NIJe9XagNKdqezpjLemoIuf7myG6WSv0H1j0LSBwFu8Ne7d+oACUZlWF6Zd2W7NrgQlMdt4I6F1mSKJMbSfPu8l9z8K+9Ap1g/byZPI9/x16SyCEK3LvcJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335129; c=relaxed/simple;
	bh=VQv1A4hMv+AzZNwVAx074GJQDPhdmioJWddsk3pMfeU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m4vZ9VfaWQJbirdczoXNLKpQU4sIgFWMdacPHoAgiZECTG0ugsfAbO7DT4FMQqgsIm9b0hliYxnpKmKnnOrEZIjT+Yvw9eTfSFOwppZ2xx+QWnBWTpj/JHj6YSNDV1kd33A9jtCml9tOkrDz0F7AqiXaNz+JrLV5o6xT1WleO7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ip8Q0uXMeJCQOngC8F+FMtRAknAr6KHnduB1hxAWF4VFTjdanAy0Q01YT10njs9vSVppSX9ce+koMqKKv4dkqlfuTFTNcGy2OCJX6I6GC8ARpBW6vD9iwIsdGE4drUZoxBkudWrwZF6r/oAUboEbTV+kgvv6lDCQStjmxmlcHwWDFh0TZzSGCbEzUotz5uORtyIKNO/8AKcjaa1k0oSz2PSQKjgOmLMOKE6bwAlQa/3fhaD600RbjfVtrmOQxYDmwPpmcsBP3uymKYSa/LxAxO167Er1E/G1E2zntiVA+e4WExvZXrHus7DEXSsGJyD6aUP6J5PahcqbTZOs6fswdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kivwbkyPkZ1zgwpzmg25W5gQq+8MrGkOVVPzJug4F/8=;
 b=I6HQQ4musdSZV+ttgFeT/4ZRn4P2jh58FCPh1Zy18TOx4znoHYULihzSDGkbAd97m8GMGht+eMlhJrBE/u6/IAZ0j/c0W2DSxfq57paMRTUaqLXC0eW7aQxxHN5B9VDSkFQuDEeWAYvLjG+ntZLK6TheFtZn0pp5OEIUVsbC1z42GUDd8sPllU1HDjQa14Fll9nzRtpXZJ4K5XfgckJCl7pfP1E/Ha23jGEQ7sryDn+picjhH7yeHdVOYCjVYjetNiJYY9BOMnCs8MVPadJI7f/F5DFVcE61DTa2Zv37fy9odpUjapeRcJw4CMRwsHqkFQIXWgTzs4dRIgCk842TKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by MAYP287MB3659.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:14b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 14:25:21 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 14:25:21 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: akpm@linux-foundation.org,
	bcain@quicinc.com
Cc: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hexagon: time: Remove redundant null check for resource
Date: Mon, 11 Nov 2024 19:54:10 +0530
Message-ID: <20241111142458.67854-1-hardevsinh.palaniya@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::12) To PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::8)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0P287MB2843:EE_|MAYP287MB3659:EE_
X-MS-Office365-Filtering-Correlation-Id: ddac8092-7a2b-4638-e515-08dd025cac5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PSgb+GK9QwixIgqZfNx6eTC45CxBdwAGxzUTU8DrdjKPWhKxp6dxyuFHjdsY?=
 =?us-ascii?Q?987QX93G5VLyzAmu3phZ0G72JOnrA8OToQDtugfvX29aicFlULTVbvoTvwn3?=
 =?us-ascii?Q?Kz0NzM+RJ7kL0dnKR7QLpJ+3mUd9EguccDVhet+siY80sopAip1VNkhT6YIq?=
 =?us-ascii?Q?VdzyzWZpBeJoMQgQIxcddKqtvz4hoDCVy10wXmHj1xPbICSzrulC3JPBZLTD?=
 =?us-ascii?Q?5m6zhge+6yq1SM+y84+wYke/vf94Y0YJJzDeq2/WXf4ZsT6U1A5ko4Ec+ZPz?=
 =?us-ascii?Q?YLWEW3xkJO82RfJjj+Oku8p5lJpoWYSy/5YLepmQRilG9WpfS/uwxE8yjyRk?=
 =?us-ascii?Q?OZP9soxuwQlq6o1TqwGMlCHUajsmhI5cKIMrHywhoG+LBnQkttpHQUt+7N5R?=
 =?us-ascii?Q?c22gmFt6Y35EAT+S5XtIZWD+aKCe1y4YdPKVACaHsdDj7XPxLkepNIX3vqxa?=
 =?us-ascii?Q?+bvUfM1BVVL1E7I/IwYLMWVyAV3cK40O65YjvYwEyrIpdr/1EhbS1sfl9GIf?=
 =?us-ascii?Q?JE/g2EX9DjuiSqDqvOLmR6cPT3gUycX5ukGeeMUcvAuXmdaa7V5hJkdLansf?=
 =?us-ascii?Q?nbYvRd7Fykly6A3dxpxIkWONGyBVfUWAS4DTOHLgZ5emFAbE3zNXnQxqNW+8?=
 =?us-ascii?Q?bolualKgd7OVUWXIL4sp0iFzkatdmMoqFwJnTyPTVJ7Skv8o5BIusE3ZrPf0?=
 =?us-ascii?Q?iA0w5soJAGAbQHeEBeZSVThDSxQPrOUOF08nO/rVt9Q2HHWiMVjhidlQk5tR?=
 =?us-ascii?Q?Iqyee2ue9WYBbbuoGruBaI5legOhx/yH+4UEQTOmaUs5CmNsi9dt7TXGBo9z?=
 =?us-ascii?Q?eqRTEpexj9J/HX8vSK/SGotL2MWHyhAAlvx/8/Uy9lWmTcV4oeymN1s82NpC?=
 =?us-ascii?Q?DS2IfO8v3aUizVVaJpBTpkrbYYV4drf4DAf1XG0TGBe4bd6IlmK/KaPPGXuO?=
 =?us-ascii?Q?0BulKnZ+Hx6JwDIRDWgfy/BpabLUw7Ma4OZuTOzF65g+YyN0jZDrfUU7MivA?=
 =?us-ascii?Q?JPMqz8qFastb3G7L3ud6OO/ZFS+kE0P+lXWkFHY6HvVM8kwsl6ZZK9CYVPhn?=
 =?us-ascii?Q?iIZhR+XuG+QxwXVBpytD+xaTwnJp+QiSmPSj911npLlbSirPIZ2kNhu6Azqs?=
 =?us-ascii?Q?E8snq4WI5propZPYycGfqIwmTs9Vn9zw6CtiBioNnBxv9F1D1IwTcor1YQpv?=
 =?us-ascii?Q?oZLxXG1D0KfJ1LwQlGUlEUUAHm+nA+Jq6CQ+znCCdS6EImKwO8lppEFFjZYw?=
 =?us-ascii?Q?wHHG5/+4wUs08+0d6zNV12zMSp3Ivz7Jtza3HqN6MGFJv5mJbWbdXbs1qJKy?=
 =?us-ascii?Q?OmJe0dTq0zJ8xrFo+zTvG9bcNklFyP029gXre/fhh91MK+kNWVa+zp2Ht2JR?=
 =?us-ascii?Q?lgm4ar8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6zR0mDWyL5fMy0rVGdHKhWGOiv3B0yWyMUG+lZsfOLrrSF/7+EWPsQSvwka?=
 =?us-ascii?Q?b/xY/ZqOJ8/V/sFOvG/7eefO3XvMnJpSUc4EUIYgAirTdlaRIhnomIQjUCoF?=
 =?us-ascii?Q?0U6L18NCbg4qNft/Npj1BxVD3FL85UYk7LA/INLUqvvgq7BWa4+q7vbBuuZp?=
 =?us-ascii?Q?b6JD0wVDBL6TmlY9e1k8wdxAjZdUVVbBGImKYcqQ+1KJf5dkeIXfJSvk9wxw?=
 =?us-ascii?Q?9i+nQdk+tvYFIbB27zSElbfegeV40G4nFeiXhc91o2h1f6/VdqewnLLbkn/W?=
 =?us-ascii?Q?+lLnRtPiFsSeALa1xQElN5Dvl/qbs7fPYfZYBJTHDUlvl/gsv2UGGQnOw5Vp?=
 =?us-ascii?Q?dfM/7X/AXJMPGpWiR95wW7oq2IWOFY/F+12NJJW4EU3nPKm4sqzJNEZZGCXO?=
 =?us-ascii?Q?5H83Fadd+7mgugzBHlSaOHJH5wQIZpBPAXqRdmTM/zAQO6xAbBr4tyxWMPHe?=
 =?us-ascii?Q?fJKT6zOUNJz1HqXmd6cNJTixzwoKHsvf/eWfIQEjU1JlIdkpXxgLWLLbHFOX?=
 =?us-ascii?Q?gSEUZkMoRv91qOEABkxdHmPh43ssEbfHXWCxVNYiEqOPuqNwa16NzEwl8txD?=
 =?us-ascii?Q?2F3bCZX8BhSTxRMDyZdIwwtM+m+K5/dIp0Yu3LREkjDcsbzBaD4e9yPWvlsA?=
 =?us-ascii?Q?rVw2vlLFsrTRjOvx3fIx1oB5t3UewzDjy/fbIrfBlVGp1P9YtbvGLgcxurvL?=
 =?us-ascii?Q?zIOyxd+BUzImo7hcSzN/CPercoMXRUUCAo+AuQ7qaYEozHrdMM6A0dV5gkJ1?=
 =?us-ascii?Q?UwkZQmPFitNWD8GfI1RNlKxecxWx9hk8ndb4om3wypaGntezHXf/46fZUkPx?=
 =?us-ascii?Q?xFLf772uC/ETEHNTx/YAIKRyz59Cop7si4Ip9XEeiCan464cFoYe7cl8Yl/8?=
 =?us-ascii?Q?FJd/dEONhlhDgJWQObFbXYI7XjvP5ucNh7/lRMYeEdvaxVjuqDUrQ4AFZ4+S?=
 =?us-ascii?Q?G5ylaJ+I6sf84r3DU91AJp6W9z2N5p1tCJoNLxLn42UKYmlwPErqeMXTG4y3?=
 =?us-ascii?Q?peY/K0mgEcpKKm91WdkKlTtlUUF4KSXmo8E0wUbQcgTpdqx9ELAuQJSjM5Eq?=
 =?us-ascii?Q?luXoGq3ulga52PH2MGZdj70IAAdUfVn9CZ/TxX7EJDvsmpkgFS3vHzv2+9Ti?=
 =?us-ascii?Q?6g1X5bemFUhGJYIDJixibtqm1l8w3ccK/gcq6ZsVm5vneSkfUSRFCXkiFBD6?=
 =?us-ascii?Q?eZX+0g783EDUORVBFVXPdqwH6rZo9HAac2h8AhXgIu5KdbmoVoIODUfDMuIO?=
 =?us-ascii?Q?1kcmVNJE35+N60/UxNTD9mTBI4vIFtsHGgYXanAdeQP8WQyKPNJWGK6q02iT?=
 =?us-ascii?Q?cR7X/vPk8nqSPWPZCHkoIqigpW1OhvNHkueYsCvEu6t8wXfMtblEA/+Pjj8m?=
 =?us-ascii?Q?VTrb/BHYAeCl49a95ypg3s2dZdYxQ6cmjTCELWUfTg8DwumSKRrWVvQU0GS3?=
 =?us-ascii?Q?4oiS9oaCMorWpFgTIUy9tkJycNwMi6wTAi4IupkOadDtHf2cdZC9kIJk7Vhk?=
 =?us-ascii?Q?Gc8hR2pGhMIIVSUGTGWUoHyOS3v4atTqhPAQOaM5po93hWCaQUsobj6c5CIs?=
 =?us-ascii?Q?tkjKtxsYCpCvYp7W8iEX1Z64fmJ3ae73LC8ABad2yURFQ4PjvL0j5WvZa0iw?=
 =?us-ascii?Q?6hCdLBY9DNVoE2Eg4/j/RVwsXdYo5bDC5ZgrUKhXv7t4?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: ddac8092-7a2b-4638-e515-08dd025cac5e
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 14:25:21.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbO6a6aiT10VkRnoNJUa3jHcx9lcCkUKBKNvIZI0SE5WjOYiKrdoeLYTUV4Cb5CEldPLrqm7J6dFfaHjDQLyL4mx25YZysdyiNxryA92mUkhwG0gnaxOdtmh90sLuuG5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3659

Null check for 'resource' before assignment is unnecessary because the
variable 'resource' is initialized to NULL at the beginning of the function.

Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
---
 arch/hexagon/kernel/time.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index f0f207e2a694..6f851e1cd4ee 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -170,8 +170,7 @@ static void __init time_init_deferred(void)
 
 	ce_dev->cpumask = cpu_all_mask;
 
-	if (!resource)
-		resource = rtos_timer_device.resource;
+	resource = rtos_timer_device.resource;
 
 	/*  ioremap here means this has to run later, after paging init  */
 	rtos_timer = ioremap(resource->start, resource_size(resource));
-- 
2.43.0

