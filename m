Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9C746ECE0
	for <lists+kvmarm@lfdr.de>; Thu,  9 Dec 2021 17:14:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 838224B118;
	Thu,  9 Dec 2021 11:14:29 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.908
X-Spam-Level: 
X-Spam-Status: No, score=0.908 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_DKIM_INVALID=0.01]
	autolearn=unavailable
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@nvidia.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u8AolO7NX7g4; Thu,  9 Dec 2021 11:14:29 -0500 (EST)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 0CE914B10E;
	Thu,  9 Dec 2021 11:14:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id A8CA54A1B0
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Dec 2021 11:08:07 -0500 (EST)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UNvwJ1LphteH for <kvmarm@lists.cs.columbia.edu>;
 Thu,  9 Dec 2021 11:08:06 -0500 (EST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 447C949FB7
 for <kvmarm@lists.cs.columbia.edu>; Thu,  9 Dec 2021 11:08:06 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmCY/brVDHezwr7GAZUrQABvdk5HvlZPwX6dDNHffLeSm3JFmZqMhxyFb1eygdX2+3wVq4t50dTg9m+9oNkW2EtQXKYu6+pRpKMd4DPpcxcRyJGY8uN1RY85hlFuvBCgpiSJFOZPdJJDe7hHqRRLCHoiXd+c57LpMeIedXNdqvh1mNtXssKY/tYE5TQtP1yVLb9npSZxJB4G97Vijnn0dGYdHcB3Y+5qqZoNIHZ4aCXVASWQk67GlWG+BR3FHAkYGVgJF0tI7mVDaqyseWFH0M504PRTvkZsnlSAPVHRgatLCyEbIbn1uNild/dHpMnpNKwhaO0yLdmunhUGWT0N4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w0i25hBn0CjR0R9/Kwiyi8hbpyb3CnYEzMYztGPjyk=;
 b=jbaUyi6Ugpo+u6kCYBRs5nXNmqCghkEFFlH7GQktjKfEfWtZO04lyZ8X0QdqcemsmhfS+CSAyEKksYVEdkUzCtJtxQh8BwSfLEyYIAgvqy2p868terAq78MlXC8jrn0RtyYPHEBarx1RUdYKsVma+beF4vJ7V5lstP2Deitg0asKCYQFvfqW/Ui7WvkCK4etLoF8i7CMOvpYG5WPeL54JFGLWnYvv+8o6Mp66gS3AF4Glu8OrT8FINOoLKKiO6ltBhE0KojUfX3CLnY4wl1wAs24thqmMMe/I0G0iRZcWE8rNM6+ZpE656HmbhLYZpjKRhHWUGcqujExY9dkiqIQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w0i25hBn0CjR0R9/Kwiyi8hbpyb3CnYEzMYztGPjyk=;
 b=Hjdj1TFmErp/6vX+nbOkIPmG8+VFuuZeg5Qx9WhGEFd/j80lxND0dkiDdaoKgcDWC92f5RnS0r1mJmOiPqsVpVBBKYZzCTabZOsyAbsnOm0l4aKjnik+3G0SPt8kJGVvILo0sChNX9pCPT0D/Fd5DFfgZvSW8m8HrelnGAiWwTddOe1JGKulkgw11sutfaBemrPveezEF+8RiBgIceAdeco7czbVcW095bRrD1KcD9YW0pUCdGrgNmouaMHk7GBaDFd5NFeGOw6xsepzHhOYfTU6UWedIVlOu8C9Ce5BVgNqPbtqxIE5guP7RSV7G6KwnfJ1PGo+BNyPhLzgUkm+vQ==
Received: from BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 9 Dec
 2021 16:08:05 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 16:08:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 16:08:04 +0000
Date: Thu, 9 Dec 2021 12:08:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC v16 1/9] iommu: Introduce attach/detach_pasid_table API
Message-ID: <20211209160803.GR6385@nvidia.com>
References: <20211027104428.1059740-2-eric.auger@redhat.com>
 <Ya3qd6mT/DpceSm8@8bytes.org>
 <c7e26722-f78c-a93f-c425-63413aa33dde@redhat.com>
 <e6733c59-ffcb-74d4-af26-273c1ae8ce68@linux.intel.com>
 <fbeabcff-a6d4-dcc5-6687-7b32d6358fe3@redhat.com>
 <20211208125616.GN6385@nvidia.com> <YbDpZ0pf7XeZcc7z@myrica>
 <20211208183102.GD6385@nvidia.com>
 <BN9PR11MB527624080CB9302481B74C7A8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <BN9PR11MB5276D3B4B181F73A1D62361C8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D3B4B181F73A1D62361C8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:208:23c::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88693148-3d61-4c4f-d91b-08d9bb2e14f1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:EE_|BL1PR12MB5080:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5173A378F3D8EEF1CDFA8A93C2709@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dpoyg/CO32ByKCWAIBK42n+kbiHqQlEi1xx4GbRwJvguv6f60QWQesKFkQZ5vvg/a82shgC1UgWnG+k2XgXYAgeFkOjVISb2a7s/bCiL5oHg4SKnSf98CXND5XSzANkqy4hYklhXbEfmFHVT74cCzlF7ZeeHs+dwMcjq/D3w96fysKHOV0U+Jf4mn7OBJrBabN6XRyYtvexjg5FKpNoSyTPkylPNYFzvVe3vmA0S9YeAdkUhgDgc4BpvwyeQHZdyrOFpVW7WKtdNUz9VdUA8gtKT2dk1b7bVretZi2xg3j5omptXKs2XFyo6vRtKeYAhAOxIUBa/aoEAbVRBMK3u0YZhrkCgUxuutjQXdjMV0AhO4o30GwleDVZOJO00yyQYeRZ/ltkudVQY25AgETe2A+pvKw5V57SokDLoI3znFjbLB9P+TOsar9Y3d4TdbRO7MRSPkyGELIvXJm609zoyduCKSBSPqIgpK4jOOHwQRtgkciXyFfNlzN0d9RKwr2LD6b4vYKj3GPg+ZBRNXaYMjswK/P//fhgWqPa/sGfRki6iWtCs+6EAM4Jv16IOTb5SbKocF1ubogEXFOilWerHrxaZ/AHbUNVjbeQrWieDQQ9r911bDI304DUzOT9+vdbYyVOZjgOXGURpKF6v8kSdkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(6512007)(86362001)(8936002)(6486002)(1076003)(8676002)(2906002)(6506007)(54906003)(38100700002)(316002)(6916009)(7416002)(26005)(5660300002)(2616005)(66556008)(66946007)(66476007)(186003)(33656002)(508600001)(36756003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CIB1OObNBQUAXpLoCEw6MMqqIN/FC08PyXmHqSIUfMnl1lpFl/ZoPJa8uShQ?=
 =?us-ascii?Q?8QieYxQbHwhlZyOrNP2KHpG1GtHmaX3iNdvYXWo1rYL2+wSv2s6XitAo+RNB?=
 =?us-ascii?Q?06nkZ29SVi2NfTVlcvpo4iNIg6CFp2JY3NquNtHExu/bVOIiaeMDfmLvXAx2?=
 =?us-ascii?Q?dBJpSvwaGEdMa8diTFlHkSHo+xcc9uUSH+Z/2NYxylxRgrcazDtcy0KWN4QL?=
 =?us-ascii?Q?+9OedJPdYT6kDwSKzo0eDmDt7IZIDsSBsZuP4mnkWdQF+G8F+i5/HR/W04Wt?=
 =?us-ascii?Q?dFxF7NkGJoGapo4NzoluXkyo09ps/QYLNHxd0VofeYwofYnF8GoFt/UEGCT9?=
 =?us-ascii?Q?fcbpetk2UsAnH0wYbt0vTeT2LomQ5Uh+zuSJV0AjA+KFeeFFPehb9elL3dPC?=
 =?us-ascii?Q?dHXSnF7i6O96nJ0El+VET7ROnZKDhtD0evtMAkeuhE785NRLbl1xg41SwNoH?=
 =?us-ascii?Q?vKqzdVteHN/7sTj/Y4MQhZaI5gs/1Uev6fkFKAlWesoDRcMBydZqk1qMRnV1?=
 =?us-ascii?Q?p6VDYUROEM0U5vEl08LgWeHgLBi0CN/sxjZFU11a8MNAFcVgI9O0JLFmxnHh?=
 =?us-ascii?Q?OqaBVRpGossVRcvEaypr33KhtjFFI7MF+dEWRHFRYWA/6VH/JwubeYDFyXoT?=
 =?us-ascii?Q?EoGgLK2aOeWzSOR5I48st6pAP1MrDB/zwNkEK89sOC5v84IA21k33WRoOzIg?=
 =?us-ascii?Q?aq7L6AVqAlAyuNb02yy2dh/9xXl4KegIUHXv0YExvRH0hpOJO2c1Jck07eYm?=
 =?us-ascii?Q?1/+3i5w98RX9rtmnT1uaS07pLilyUeFHkGaOGM0057rHEZcyZWS58SkMruzw?=
 =?us-ascii?Q?9X7CtZN8xoHxiNWIHYKqFJH0Po4Cwf0iPihhKcNIuG9RC0kA4UeJmmmIKoos?=
 =?us-ascii?Q?UQOSCFq847GMIvbBpZxiHNpFyUOuJny9A4tmCf67Jdi1Y2hjQy4/ZDu+Ut1p?=
 =?us-ascii?Q?Ec8n4g7M7NDg5Qa87eRfddBIayhYoUbrShE9xR+cpIOgolxHLm2TWVmL6hP+?=
 =?us-ascii?Q?I7anw+4XpkiShIH89Md7Dsd5hifalK148YMT6hnnF9h4hyqf5SOACqohz7RE?=
 =?us-ascii?Q?sr7BTr6IsAWlKOt8n1mTnEsXIQZQ4hlQoIEkBtUgRwhlDtPTm5tT1oCjmhJ8?=
 =?us-ascii?Q?saV8T/mi06lgjqI2ji6r+GIMe5Kt1mkavfqdDYDFpRWfkeGiFIgnch9lzVCa?=
 =?us-ascii?Q?s3pqbLq5+UBZWvhBYpPkQ9G0hBVaM6eriC024VrnmGQEZ2ZpbPoop/0hZlz/?=
 =?us-ascii?Q?gCHOEoBt1FQWawriYSxQuSdzuiVYOvb4iqhZNmTIeR2uFcV/29OkZU//8Yaf?=
 =?us-ascii?Q?2iucqqPITG/s1MNvQPWyGl1+W4xQXakBve/I6Ra7tornj6qGGOlVHbr71Zux?=
 =?us-ascii?Q?FLivRm75K0+wrVPxmOQCscTKKlGtP0JkJeAiGpxr4zVzEjk5gB6ROEAqsOpB?=
 =?us-ascii?Q?eAOfg73FShG+rVw7cH2Let1vPO6v0gP9RYcd7sqN2WwB2DpZ4VyoDpfovDff?=
 =?us-ascii?Q?oDBCWSFn+fGdJR3xpoR27qFYyJolKtAkxsSz3X6aBJpjIvkpfF3QSHyfrqwn?=
 =?us-ascii?Q?MB+mEeTpzwDGDC7aki4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88693148-3d61-4c4f-d91b-08d9bb2e14f1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 16:08:04.5481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdwYGIuvE3melJFoyHhCViuSRRFzqS2zIAsWZ/DrNlhZtBfpMOUr/z1S9yZaoDjL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
X-Mailman-Approved-At: Thu, 09 Dec 2021 11:14:26 -0500
Cc: "lushenming@huawei.com" <lushenming@huawei.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "vsethi@nvidia.com" <vsethi@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "wangxingang5@huawei.com" <wangxingang5@huawei.com>,
 "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 Lu Baolu <baolu.lu@linux.intel.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

On Thu, Dec 09, 2021 at 03:59:57AM +0000, Tian, Kevin wrote:
> > From: Tian, Kevin
> > Sent: Thursday, December 9, 2021 10:58 AM
> > 
> > For ARM it's SMMU's PASID table format. There is no step-2 since PASID
> > is already within the address space covered by the user PASID table.
> > 
> 
> One correction here. 'no step-2' is definitely wrong here as it means
> more than user page table in your plan (e.g. dpdk).
> 
> To simplify it what I meant is:
> 
> iommufd reports how many 'user page tables' are supported given a device.
> 
> ARM always reports only one can be supported, and it must be created in 
> PASID table format. tagged by RID.
> 
> Intel reports one in step1 (tagged by RID), and N in step2 (tagged by
> RID+PASID). A special flag in attach call allows the user to specify the
> additional PASID routing info for a 'user page table'.

I don't think 'number of user page tables' makes sense

It really is 'attach to the whole device' vs 'attach to the RID' as a
semantic that should exist 

If we imagine a userspace using kernel page tables it certainly makes
sense to assign page table A to the RID and page table B to a PASID
even in simple cases like vfio-pci.

The only case where userspace would want to capture the entire RID and
all PASIDs is something like this ARM situation - but userspace just
created a device specific object and already knows exactly what kind
of behavior it has.

So, something like vfio pci would implement three uAPI operations:
 - Attach page table to RID
 - Attach page table to PASID
 - Attach page table to RID and all PASIDs
   And here 'page table' is everything below the STE in SMMUv3

While mdev can only support:
 - Access emulated page table
 - Attach page table to PASID

It is what I've said a couple of times, the API the driver calls
toward iommufd to attach a page table must be unambiguous as to the
intention, which also means userspace must be unambiguous too.

Jason
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
